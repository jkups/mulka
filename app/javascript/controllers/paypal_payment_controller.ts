import { Controller } from "@hotwired/stimulus";
import { loadScript as loadPaypalScript } from "@paypal/paypal-js";
import braintree from "braintree-web";

export default class extends Controller {
  static targets = [
    "form",
    "payWithPaypalButton",
    "payWithCardButton",
    "processingPayment",
    "unitsInput",
    "spinner",
  ];

  static values = {
    paypalId: String,
    braintreeAuthorization: String,
    braintreePrefix: String,
    trxnAmount: Number,
  };

  declare formTarget: HTMLFormElement;
  declare payWithPaypalButtonTarget: HTMLButtonElement;
  declare payWithCardButtonTarget: HTMLButtonElement;
  declare processingPaymentTarget: HTMLDivElement;
  declare unitsInputTarget: HTMLInputElement;
  declare spinnerTarget: HTMLElement;

  declare paypalIdValue: string;
  declare braintreeAuthorizationValue: string;
  declare braintreePrefixValue: string;
  declare trxnAmountValue: string;
  declare paypal_sdk;

  initialize(): void {
    loadPaypalScript({
      "client-id": this.paypalIdValue,
      "data-namespace": "paypal_sdk",
    }).then((paypal_sdk) => {
      this.paypal_sdk = paypal_sdk;
      this.createBraintreeClient();
    });
  }

  connect(): void {
    this.payWithPaypalButtonTarget.disabled = true;
    this.payWithCardButtonTarget.disabled = true;
    this.unitsInputTarget.disabled = true;
  }

  createBraintreeClient(): void {
    const clientInstance = braintree.client.create({
      authorization: this.braintreeAuthorizationValue,
    });

    this.createPaypalCheckout(clientInstance);
  }

  createPaypalCheckout(clientInstance): void {
    const paypalCheckout = clientInstance.then((clientInstance) => {
      return braintree.paypalCheckout.create({ client: clientInstance });
    });

    this.initializePaypalCheckoutInstance(paypalCheckout);
  }

  initializePaypalCheckoutInstance(paypalCheckout): void {
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
            style: { color: "blue", height: 44 },
            createOrder: () => this.createOrder(paypalCheckoutInstance),
            onApprove: (data, action) =>
              this.handleSuccess(paypalCheckoutInstance, data, action),
            onCancel: (data) => this.handleCancellation(data),
            onError: (err) => this.handleFailure(err),
          })
          .render("#paypal-button");
      })
      .then(() => {
        this.payWithPaypalButtonTarget.disabled = false;
        this.payWithCardButtonTarget.disabled = false;
        this.unitsInputTarget.disabled = false;
        this.spinnerTarget.classList.add("hidden");
        this.handleMouseOver();
      });
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

  handleSuccess(paypalCheckoutInstance, data, action): any {
    return paypalCheckoutInstance.tokenizePayment(data).then((payload) => {
      this.processingPaymentTarget.classList.replace("hidden", "flex");

      const nonceValue = `${this.braintreePrefixValue}${payload.nonce}`;
      const nonceInput = this.createInput("nonce", nonceValue);
      const paymentMethodInput = this.createInput("payment_method", "paypal");

      this.formTarget.appendChild(nonceInput).appendChild(paymentMethodInput);
      this.formTarget.submit();
    });
  }

  handleCancellation(data): void {
    console.log("PayPal payment cancelled");
  }

  handleFailure(error): void {
    console.error("PayPal error", error);
  }

  createInput(name, value): HTMLInputElement {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = `tranzaction[${name}]`;
    input.value = value;

    return input;
  }

  handleMouseOver(): void {
    const paypalButton = document.querySelector(".paypal-buttons");
    paypalButton.addEventListener("mouseover", () => {
      this.payWithPaypalButtonTarget.classList.add("bg-green-600");
    });
    paypalButton.addEventListener("mouseout", () => {
      this.payWithPaypalButtonTarget.classList.remove("bg-green-600");
    });
  }
}
