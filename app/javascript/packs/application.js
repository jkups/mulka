// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails";
// import "controllers";
import Bugsnag from "@bugsnag/js";
Bugsnag.start({ apiKey: "" });

import Rails from "@rails/ujs";
Rails.start();

import "intl-tel-input/build/css/intlTelInput.css";
import "@fortawesome/fontawesome-free/css/all.css";
import "stylesheets/application.scss";
import "controllers";

import ApexCharts from "apexcharts";
window.ApexCharts = ApexCharts;
