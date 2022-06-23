import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "unitsInput",
    "refreshPriceButton",
    "payWithPaypalButton",
    "payWithCardButton",
  ];

  static values = {
    min: Number,
    max: Number,
  };

  declare unitsInputTarget: HTMLInputElement;
  declare refreshPriceButtonTarget: HTMLDivElement;
  declare payWithPaypalButtonTarget: HTMLButtonElement;
  declare payWithCardButtonTarget: HTMLButtonElement;
  declare minValue: number;
  declare maxValue: number;

  update(): void {
    this.disablePayButtons();
    this.showRefreshButton();
    this.formatInput();
  }

  formatInput(): void {
    const units = parseInt(this.unitsInputTarget.value);
    this.unitsInputTarget.value = `${units}`;

    if (units > this.maxValue) {
      this.unitsInputTarget.value = `${this.maxValue}`;
    } else if (units < this.minValue) {
      this.unitsInputTarget.value = `${this.minValue}`;
    }
  }

  disablePayButtons(): void {
    this.payWithPaypalButtonTarget.disabled = true;
    this.payWithCardButtonTarget.disabled = true;
  }

  showRefreshButton(): void {
    this.refreshPriceButtonTarget.classList.remove("hidden");
  }
}
