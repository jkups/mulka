import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "unitsInput",
    "refreshPriceButton",
    "payWithPaypalButton",
    "payWithCardButton",
    "eoiButton",
  ];

  static values = {
    min: Number,
    max: Number,
  };

  declare unitsInputTarget: HTMLInputElement;
  declare refreshPriceButtonTarget: HTMLDivElement;
  declare payWithPaypalButtonTarget: HTMLButtonElement;
  declare payWithCardButtonTarget: HTMLButtonElement;
  declare eoiButtonTarget: HTMLButtonElement;
  declare hasPayWithPaypalButtonTarget: Boolean;
  declare hasEoiButtonTarget: Boolean;
  declare minValue: number;
  declare maxValue: number;

  update(): void {
    this.disablePayButtons();
    this.disableEOIButton();
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
    if (this.hasPayWithPaypalButtonTarget) {
      this.payWithPaypalButtonTarget.disabled = true;
      this.payWithCardButtonTarget.disabled = true;
    }
  }

  disableEOIButton(): void {
    if (this.hasEoiButtonTarget) {
      this.eoiButtonTarget.disabled = true;
    }
  }

  showRefreshButton(): void {
    this.refreshPriceButtonTarget.classList.remove("hidden");
  }
}
