import { Controller } from "@hotwired/stimulus";
import { loadScript as loadPaypalScript } from "@paypal/paypal-js";
import Bugsnag fom "@bugsnag/browser";
import * as braintree from "braintree-web";

export default class extends Controller {
  static targets = [
    "form",
    "paypalButtonContainer",
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
  declare paypalButtonContainerTarget: HTMLDivElement;
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
    this.paypalButtonContainerTarget.classList.toggle("hidden");
    this.unitsInputTarget.disabled = true;
  }

  createBraintreeClient(): void {
    const clientInstance = braintree.client.create({
      authorization: this.braintreeAuthorizationValue,
    });

    this.createPaypalCheckout(clientInstance);
  }

  createPaypalCheckout(clientInstance: Promise<braintree.Client>): void {
    const paypalCheckout = clientInstance.then((clientInstance) => {
      return braintree.paypalCheckout.create({ client: clientInstance });
    });

    this.initializePaypalCheckoutInstance(paypalCheckout);
  }

  initializePaypalCheckoutInstance(
    paypalCheckout: Promise<braintree.PayPalCheckout>
  ): void {
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

  renderPaypalButton(
    paypalCheckoutInstance: Promise<braintree.PayPalCheckout>
  ): void {
    const paypalButtonStyle = { color: "blue", height: 44 };

    paypalCheckoutInstance
      .then((paypalCheckoutInstance) => {
        return this.paypal_sdk
          .Buttons({
            fundingSource: this.paypal_sdk.FUNDING.PAYPAL,
            style: paypalButtonStyle,
            createOrder: () => this.createOrder(paypalCheckoutInstance),
            onApprove: (data: any, actions: any) =>
              this.handleSuccess(paypalCheckoutInstance, data, actions),
            onCancel: (data: any) => this.handleCancellation(data),
            onError: (err: braintree.BraintreeError) => this.handleFailure(err),
          })
          .render("#paypal-button");
      })
      .then(() => {
        this.payWithPaypalButtonTarget.disabled = false;
        this.payWithCardButtonTarget.disabled = false;
        this.unitsInputTarget.disabled = false;
        this.spinnerTarget.classList.add("hidden");
        this.paypalButtonContainerTarget.classList.toggle("hidden");
        this.handleMouseOver();
      });
  }

  createOrder(paypalCheckoutInstance: braintree.PayPalCheckout): any {
    return paypalCheckoutInstance.createPayment({
      flow: "checkout",
      amount: this.trxnAmountValue,
      currency: "USD",
      intent: "capture",
      displayName: "Mulka",
    } as braintree.PayPalCheckoutCreatePaymentOptions);
  }

  handleSuccess(
    paypalCheckoutInstance: braintree.PayPalCheckout,
    data: any,
    actions: any
  ): any {
    return paypalCheckoutInstance.tokenizePayment(data).then((payload) => {
      this.processingPaymentTarget.classList.replace("hidden", "flex");

      const nonceValue = `${this.braintreePrefixValue}${payload.nonce}`;
      const nonceInput = this.createInput("nonce", nonceValue);
      const paymentMethodInput = this.createInput("payment_method", "paypal");

      this.formTarget.appendChild(nonceInput).appendChild(paymentMethodInput);
      this.formTarget.submit();
    });
  }

  handleCancellation(data: any): void {
    // handle cancellation - do nothing!
    // returns the orderID [object Object]
  }

  handleFailure(error: braintree.BraintreeError): void {
    const toast = document.querySelector("#toast") as HTMLDivElement;
    const flash = toast.querySelector("div") as HTMLDivElement;
    flash.classList.remove("hidden");
    toast.classList.remove("hidden");

    setTimeout(() => {
      flash.classList.add("hidden");
      toast.classList.add("hidden");
    }, 5000);

    Bugsnag.notify({
      name: error.code,
      message: error.message,
    });
  }

  createInput(name: string, value: string): HTMLInputElement {
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
