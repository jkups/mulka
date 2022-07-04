import { Controller } from "@hotwired/stimulus";
import Bugsnag from "@bugsnag/browser";
import * as braintree from "braintree-web";

export default class extends Controller {
  static targets = ["form", "payWithCardButton", "processingPayment"];

  static values = {
    braintreeAuthorization: String,
    braintreePrefix: String,
    trxnAmount: Number,
  };

  declare formTarget: HTMLFormElement;
  declare payWithCardButtonTarget: HTMLButtonElement;
  declare processingPaymentTarget: HTMLDivElement;

  declare braintreeAuthorizationValue: string;
  declare braintreePrefixValue: string;
  declare trxnAmountValue: string;
  declare hostedFields: braintree.HostedFields;

  connect(): void {
    this.payWithCardButtonTarget.disabled = true;
    this.createBraintreeClient();
  }

  createBraintreeClient(): void {
    const clientInstance = braintree.client.create({
      authorization: this.braintreeAuthorizationValue,
    });

    this.createHostedFields(clientInstance);
  }

  createHostedFields(clientInstance: Promise<braintree.Client>): void {
    const createdHostedFields = clientInstance.then((client) => {
      return braintree.hostedFields.create({
        client: client,
        styles: this.stylesConfig(),
        fields: this.fieldsConfig(),
      });
    });

    this.hostedFieldsEventListeners(createdHostedFields);
  }

  hostedFieldsEventListeners(
    createdHostedFields: Promise<braintree.HostedFields>
  ): void {
    createdHostedFields
      .then((hostedFields) => {
        this.hostedFields = hostedFields;
        // this.payWithCardButtonTarget.disabled = false;

        hostedFields.on("empty", (event) => this.onEmpty(event));
        hostedFields.on("validityChange", (event) =>
          this.onValidityChange(event)
        );
        hostedFields.on("cardTypeChange", (event) =>
          this.onCardTypeChange(event)
        );
      })
      .catch((error) => this.handleFieldErrors(error));
  }

  onEmpty(event: braintree.HostedFieldsEvent): void {
    // do nothing
  }

  onCardTypeChange(event: braintree.HostedFieldsEvent): void {
    // do nothing
  }

  handleFieldErrors(error: braintree.BraintreeError): void {
    Bugsnag.notify({
      name: error.code,
      message: error.message,
    });
  }

  onValidityChange(event: braintree.HostedFieldsEvent): void {
    const isFieldsValid = Object.values(event.fields).every(
      (field) => field.isValid
    );

    this.payWithCardButtonTarget.disabled = isFieldsValid ? false : true;
  }

  processPayment(event: Event): void {
    event.preventDefault();
    this.processingPaymentTarget.classList.replace("hidden", "flex");
    const cardholderName = document.querySelector(
      ".cardholderName"
    ) as HTMLInputElement;

    this.hostedFields
      .tokenize({ cardholderName: cardholderName.value })
      .then((payload) => this.handleSuccess(payload))
      .catch((error) => this.handleFailure(error));
  }

  handleSuccess(payload: braintree.HostedFieldsTokenizePayload): void {
    const nonceValue = `${this.braintreePrefixValue}${payload.nonce}`;
    const nonceInput = this.createInput("nonce", nonceValue);
    const paymentMethodInput = this.createInput("payment_method", "card");

    this.formTarget.appendChild(nonceInput).appendChild(paymentMethodInput);
    this.formTarget.submit();
  }

  handleFailure(error: braintree.BraintreeError): void {
    this.processingPaymentTarget.classList.replace("flex", "hidden");
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

  fieldsConfig(): braintree.HostedFieldFieldOptions {
    return {
      cardholderName: { selector: "#cardholder-name" },
      number: {
        selector: "#card-number",
        maskInput: { character: "*", showLastFour: true },
      },
      cvv: { selector: "#cvv", type: "password" },
      expirationDate: { selector: "#expiration", placeholder: "MM / YY" },
    };
  }

  stylesConfig(): any {
    return {
      input: { "font-size": "18px", color: "#15b881" },
      "input.invalid": { color: "#991b1b" },
      "input.valid": { color: "#15b881" },
    };
  }
}
