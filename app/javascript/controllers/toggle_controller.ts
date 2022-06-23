import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable"];
  declare toggleableTargets: HTMLElement[];

  toggle(): void {
    this.toggleableTargets.forEach((toggleableTarget) =>
      toggleableTarget.classList.toggle("hidden")
    );
  }
}
