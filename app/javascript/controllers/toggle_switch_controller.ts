import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["switch", "toggleable"];
  declare switchTarget: HTMLElement;
  declare toggleableTargets: HTMLElement[];

  toggle(event: Event): void {
    event.preventDefault();
    this.switchTarget.classList.toggle("right-0");
    this.toggleableTargets.forEach((toggleableTarget) =>
      toggleableTarget.classList.toggle("hidden")
    );
  }
}
