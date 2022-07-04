import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";

export default class extends Controller {
  static targets = ["mobileNumberInput"];
  static values = { allowedCountries: Array };

  declare mobileNumberInputTarget: HTMLInputElement;
  declare allowedCountriesValue: string[];
  declare iti;

  connect(): void {
    const libPhoneNumberUtils =
      "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.17/js/utils.min.js";

    this.iti = intlTelInput(this.mobileNumberInputTarget, {
      onlyCountries: this.allowedCountriesValue,
      hiddenInput: "mobile_number",
      separateDialCode: true,
      utilsScript: libPhoneNumberUtils,
    });
  }

  setMobileNumber(): void {
    const hiddenMobileNumberInput = document.querySelector(
      "[name='profile[mobile_number]']"
    ) as HTMLInputElement;

    const dialCode = this.iti.getSelectedCountryData().dialCode;
    hiddenMobileNumberInput.value = `+${dialCode}${this.mobileNumberInputTarget.value}`;
  }
}
