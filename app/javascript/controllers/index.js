// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import CardPaymentController from "./card_payment_controller.ts";
application.register("card-payment", CardPaymentController);

import DropdownMenuController from "./dropdown_menu_controller.ts";
application.register("dropdown-menu", DropdownMenuController);

import FileUploadController from "./file_upload_controller.ts";
application.register("file-upload", FileUploadController);

import FlashController from "./flash_controller.js";
application.register("flash", FlashController);

import GooglePlacesAutocompleteController from "./google_places_autocomplete_controller.ts";
application.register(
  "google-places-autocomplete",
  GooglePlacesAutocompleteController
);

import IntlTelephoneController from "./intl_telephone_controller.ts";
application.register("intl-telephone", IntlTelephoneController);

import NumberOfUnitsController from "./number_of_units_controller.ts";
application.register("number-of-units", NumberOfUnitsController);

import PageReloadController from "./page_reload_controller.ts";
application.register("page-reload", PageReloadController);

import PaypalPaymentController from "./paypal_payment_controller.ts";
application.register("paypal-payment", PaypalPaymentController);

import PortfolioController from "./portfolio_controller.ts";
application.register("portfolio", PortfolioController);

import TabController from "./tab_controller.ts";
application.register("tab", TabController);

import ToggleController from "./toggle_controller.ts";
application.register("toggle", ToggleController);

import ToggleModalController from "./toggle_modal_controller.ts";
application.register("toggle-modal", ToggleModalController);

import ToggleSwitchController from "./toggle_switch_controller.ts";
application.register("toggle-switch", ToggleSwitchController);
