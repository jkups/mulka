import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];
  static values = {
    url: String,
  };
  declare formTarget: HTMLFormElement;
  declare urlValue: string;

  refreshWithParams(): void {
    console.log("am here");
    this.formTarget.setAttribute("method", "get");
    this.formTarget.setAttribute("action", this.urlValue);
    this.formTarget.firstChild.remove();
    this.formTarget.submit();
  }
}
