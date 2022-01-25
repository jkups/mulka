import { Controller } from "@hotwired/stimulus";
import { loadScript as loadPaypalScript } from "@paypal/paypal-js";
import braintree from "braintree-web";

// Connects to data-controller="paypal-client"
export default class extends Controller {
  static targets = ["form", "submitButton"];
  declare formTarget: HTMLFormElement;
  declare submitButtonTarget: HTMLButtonElement;
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

  initialize(): void {
    // load paypal checkout script
    loadPaypalScript({
      "client-id": this.paypalIdValue,
      "data-namespace": "paypal_sdk",
    }).then((paypal_sdk) => {
      this.paypal_sdk = paypal_sdk;
      this.createBraintreeClient();
    });
  }

  connect(): void {
    this.submitButtonTarget.disabled = true;
  }

  createBraintreeClient(): void {
    const clientInstance = braintree.client.create({
      authorization: this.braintreeAuthorizationValue,
    });

    this.createPaypalCheckout(clientInstance);
  }

  createPaypalCheckout(clientInstance): void {
    // Create a paypal checkout component.
    const paypalCheckout = clientInstance.then((clientInstance) => {
      return braintree.paypalCheckout.create({ client: clientInstance });
    });

    this.initPaypalCheckoutInstance(paypalCheckout);
  }

  initPaypalCheckoutInstance(paypalCheckout): void {
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

  renderPaypalButton(paypalCheckoutInstance): void {
    paypalCheckoutInstance
      .then((paypalCheckoutInstance) => {
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
      })
      .then(() => (this.submitButtonTarget.disabled = false));
  }

  createOrder(paypalCheckoutInstance): any {
    return paypalCheckoutInstance.createPayment({
      flow: "checkout",
      amount: this.trxnAmountValue,
      currency: "USD",
      intent: "capture",
      displayName: "Mulka",
    });
  }

  publishPayload(paypalCheckoutInstance, data, action): any {
    return paypalCheckoutInstance.tokenizePayment(data).then((payload) => {
      const nonce_input = document.createElement("input");
      nonce_input.type = "hidden";
      nonce_input.name = "property[nonce]";
      nonce_input.value = `${this.braintreePrefixValue}${payload.nonce}`;

      this.formTarget.appendChild(nonce_input);
      this.formTarget.submit();
    });
  }

  orderIsCancelled(data): void {
    console.log("PayPal payment cancelled");
  }

  trxnFailed(error): void {
    console.error("PayPal error", error);
  }
}
