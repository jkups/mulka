import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect(): void {
    console.log("am here");
  }
  toggle(event) {
    event.preventDefault();

    const element = event.currentTarget as HTMLElement;
    const elements = document.querySelectorAll(
      `[data-id="${element.dataset.id}"`
    );
    const targetContainer = elements[elements.length - 1];
    targetContainer.classList.toggle("hidden");
    element.classList.toggle("rotate-180");
  }
}
