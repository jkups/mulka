import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];
  declare menuTarget: HTMLElement;

  toggle(event: Event): void {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
  }

  hide(): void {
    this.menuTarget.classList.add("hidden");
  }
}
