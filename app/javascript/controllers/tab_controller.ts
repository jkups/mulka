import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "tabable"];
  static values = {
    activeTextColor: String,
    activeBackgroundColor: String,
  };

  declare tabTargets: HTMLElement[];
  declare tabableTargets: HTMLElement[];
  declare activeTextColorValue: string;
  declare activeBackgroundColorValue: string;

  toggle(event): void {
    event.preventDefault();
    this.hideAllPages();
    this.deActivateAllTabs();

    const target = event.currentTarget;
    target.classList.add(
      this.activeBackgroundColorValue,
      this.activeTextColorValue
    );

    const targetPage = this.findTargetPage(target.dataset.id);
    targetPage.classList.remove("hidden");
  }

  findTargetPage(id: string): HTMLElement {
    return this.tabableTargets.find(
      (tabableTarget) => tabableTarget.dataset.id == `page-${id}`
    );
  }

  hideAllPages(): void {
    this.tabableTargets.forEach((tabableTarget) =>
      tabableTarget.classList.add("hidden")
    );
  }

  deActivateAllTabs(): void {
    this.tabTargets.forEach((tabTarget) =>
      tabTarget.classList.remove(
        this.activeBackgroundColorValue,
        this.activeTextColorValue
      )
    );
  }
}
