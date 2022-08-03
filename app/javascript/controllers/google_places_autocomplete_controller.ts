import { Controller } from "@hotwired/stimulus";

type AddressType = {
  street_number: "street_number";
  route: "route";
  locality: "locality";
  administrative_area_level_1: "administrative_area_level_1";
  country: "country";
  postal_code: "postal_code";
};

type ComponentFormType = {
  [Property in keyof AddressType]: string;
};

export default class extends Controller {
  static targets = [
    "autoComplete",
    "streetAddress",
    "suburb",
    "subdivision",
    "country",
  ];

  private componentForm: ComponentFormType = {
    street_number: "short_name",
    route: "long_name",
    locality: "long_name",
    administrative_area_level_1: "short_name",
    country: "short_name",
    postal_code: "short_name",
  };

  declare autoCompleteTarget: HTMLInputElement;
  declare streetAddressTarget: HTMLInputElement;
  declare suburbTarget: HTMLInputElement;
  declare subdivisionTarget: HTMLInputElement;
  declare countryTarget: HTMLInputElement;
  declare placeSearch: google.maps.places.PlaceSearchRequest;
  declare autoComplete: google.maps.places.Autocomplete;

  connect() {
    this.initAutocomplete();
  }

  initAutocomplete = (): void => {
    this.autoComplete = new google.maps.places.Autocomplete(
      this.autoCompleteTarget,
      { types: ["geocode"] }
    );

    this.autoComplete.setFields(["address_component"]);
    this.autoComplete.addListener("place_changed", this.fillInAddress);
  };

  fillInAddress = (): void => {
    this.resetAddressFields();
    const selectedAddress = this.getSelectedAddress();
    this.populateAddressFields(selectedAddress);
  };

  geolocate = (): void => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };

        const circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy,
        });

        this.autoComplete.setBounds(circle.getBounds());
      });
    }
  };

  getSelectedAddress = (): any => {
    const addressComponents = this.autoComplete.getPlace().address_components;

    return addressComponents.reduce((accumulator, addressComponent) => {
      const addressType = addressComponent.types[0];
      if (this.componentForm[addressType]) {
        accumulator[addressType] =
          addressComponent[this.componentForm[addressType]];
      }

      return accumulator;
    }, {});
  };

  resetAddressFields = (): void => {
    this.streetAddressTarget.value = "";
    this.suburbTarget.value = "";
    this.subdivisionTarget.value = "";
    this.countryTarget.value = "";
  };

  populateAddressFields = (selectedAddress): void => {
    this.streetAddressTarget.value = this.getStreetAddress(selectedAddress);
    this.suburbTarget.value = this.getSuburb(selectedAddress);
    this.subdivisionTarget.value =
      selectedAddress["administrative_area_level_1"];
    this.countryTarget.value = selectedAddress["country"];
  };

  getStreetAddress = (address): string => {
    return `${address["street_number"]} ${address["route"]}`;
  };

  getSuburb = (address): string => {
    return `${address["locality"]} ${address["postal_code"]}`;
  };
}
