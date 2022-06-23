import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect(): void {
    const query = new URLSearchParams(window.location.search);
    const transaction_id = query.get("transaction_id");
    const offer_id = query.get("offer_id");

    if (offer_id && transaction_id) {
      const element = document.querySelector(`[data-id="${offer_id}"`);

      this.toggleTrxnContainer(element as HTMLElement);
      this.highlightCurrentTrxn(transaction_id);
    }
  }

  toggleTrxnContainer(element: Event | HTMLElement): void {
    if (element instanceof Event) {
      element.preventDefault();
      element = element.currentTarget as HTMLElement;
    }

    element.classList.toggle("rotate-180");
    this.toggle(element.dataset.id);
  }

  toggle(id: string): void {
    const elements = document.querySelectorAll(`[data-id="${id}"`);
    const targetContainer = elements[elements.length - 1];
    targetContainer.classList.toggle("hidden");
  }

  highlightCurrentTrxn(id: string): void {
    const element = document.querySelector(`[data-id="${id}"`);
    element.classList.replace("bg-green-50", "bg-yellow-300");

    setTimeout(() => {
      element.classList.replace("bg-yellow-300", "bg-green-50");
    }, 5000);
  }
}
