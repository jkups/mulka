import { Controller } from "@hotwired/stimulus";
import braintree from "braintree-web";

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
  declare hostedFields;

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

  createHostedFields(clientInstance): void {
    const createdHostedFields = clientInstance.then((client) => {
      return braintree.hostedFields.create({
        client: client,
        styles: this.stylesConfig(),
        fields: this.fieldsConfig(),
      });
    });

    this.hostedFieldsEventListeners(createdHostedFields);
  }

  hostedFieldsEventListeners(createdHostedFields): void {
    createdHostedFields
      .then((hostedFields) => {
        this.hostedFields = hostedFields;
        this.payWithCardButtonTarget.disabled = false;

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

  onEmpty(event): void {}

  onValidityChange(event): void {}

  onCardTypeChange(event): void {}

  handleFieldErrors(error): void {}

  processPayment(event): void {
    event.preventDefault();

    const state = this.hostedFields.getState();
    const isFieldsValid = Object.keys(state.fields).every(
      (key) => state.fields[key].isValid
    );

    if (isFieldsValid) {
      this.processingPaymentTarget.classList.replace("hidden", "flex");

      this.hostedFields
        .tokenize({ cardholderName: "" })
        .then((payload) => this.handleSuccess(payload))
        .catch((error) => this.handleFailure(error));
    }
  }

  handleSuccess(payload): void {
    const nonceValue = `${this.braintreePrefixValue}${payload.nonce}`;
    const nonceInput = this.createInput("nonce", nonceValue);
    const paymentMethodInput = this.createInput("payment_method", "card");

    this.formTarget.appendChild(nonceInput).appendChild(paymentMethodInput);
    this.formTarget.submit();
  }

  handleFailure(error): void {
    this.processingPaymentTarget.classList.replace("flex", "hidden");
    console.error("Card error", error);
  }

  createInput(name, value): HTMLInputElement {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = `tranzaction[${name}]`;
    input.value = value;

    return input;
  }

  fieldsConfig() {
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

  stylesConfig() {
    return {
      input: { "font-size": "18px", color: "#15b881" },
      "input.invalid": { color: "#991b1b" },
      "input.valid": { color: "#15b881" },
    };
  }
}
