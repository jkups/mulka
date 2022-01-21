import { Controller } from "@hotwired/stimulus";
import { loadScript as loadPaypalScript } from "@paypal/paypal-js";
import braintree from "braintree-web";

// Connects to data-controller="paypal-client"
export default class extends Controller {
  static targets = ["form"];
  declare formTarget: HTMLFormElement;
  declare paypal_sdk;

  static values = {
    paypalId: String,
    braintreeAuthorization: String,
    braintreePrefix: String,
    trxnAmount: Number,
  };

  declare paypalIdValue: string;
  declare braintreeAuthorizationValue: string;
  declare braintreePrefixValue: string;
  declare trxnAmountValue: string;

  initialize() {
    // load paypal checkout script
    loadPaypalScript({
      "client-id": this.paypalIdValue,
      "data-namespace": "paypal_sdk",
    }).then((paypal_sdk) => {
      this.paypal_sdk = paypal_sdk;
      this.createBraintreeClient();
    });
  }

  createBraintreeClient() {
    const clientInstance = braintree.client.create({
      authorization: this.braintreeAuthorizationValue,
    });

    this.createPaypalCheckout(clientInstance);
  }

  createPaypalCheckout(clientInstance) {
    // Create a paypal checkout component.
    const paypalCheckout = clientInstance.then((clientInstance) => {
      return braintree.paypalCheckout.create({ client: clientInstance });
    });

    this.initPaypalCheckoutInstance(paypalCheckout);
  }

  initPaypalCheckoutInstance(paypalCheckout) {
    const paypalCheckoutInstance = paypalCheckout.then(
      (paypalCheckoutInstance) => {
        return paypalCheckoutInstance.loadPayPalSDK({
          currency: "USD",
          intent: "capture",
        });
      }
    );

    this.renderPaypalButton(paypalCheckoutInstance);
  }

  renderPaypalButton(paypalCheckoutInstance) {
    paypalCheckoutInstance.then((paypalCheckoutInstance) => {
      return this.paypal_sdk
        .Buttons({
          fundingSource: this.paypal_sdk.FUNDING.PAYPAL,
          style: { color: "blue" },
          createOrder: () => this.createOrder(paypalCheckoutInstance),
          onApprove: (data, action) =>
            this.publishPayload(paypalCheckoutInstance, data, action),
          onCancel: (data) => this.orderIsCancelled(data),
          onError: (err) => this.trxnFailed(err),
        })
        .render("#paypal-button");
    });
  }

  createOrder(paypalCheckoutInstance) {
    return paypalCheckoutInstance.createPayment({
      flow: "checkout",
      amount: this.trxnAmountValue,
      currency: "USD",
      intent: "capture",
      displayName: "Mulka",
    });
  }

  publishPayload(paypalCheckoutInstance, data, action) {
    return paypalCheckoutInstance.tokenizePayment(data).then((payload) => {
      const nonce_input = document.createElement("input");
      nonce_input.type = "hidden";
      nonce_input.name = "property[nonce]";
      nonce_input.value = `${this.braintreePrefixValue}${payload.nonce}`;

      this.formTarget.appendChild(nonce_input);
      this.formTarget.submit();
    });
  }

  orderIsCancelled(data) {
    console.log("PayPal payment cancelled");
  }

  trxnFailed(error) {
    console.error("PayPal error", error);
  }
}
