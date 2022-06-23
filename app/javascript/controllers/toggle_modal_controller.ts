import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    modal: String,
  };

  declare modalValue: string;

  show(event): void {
    event.preventDefault();
    const modal = document.querySelector(`#${this.modalValue}`);
    modal.classList.remove("hidden");
  }

  hide(event): void {
    event.preventDefault();
    const modal = document.querySelector(`#${this.modalValue}`);
    modal.classList.add("hidden");
  }
}
