import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["card", "count", "checkbox"];

  connect() {
    this.countTasks()
  }
  countTasks() {
    this.cardTarget.classList.remove("completed");
    this.cardTarget.classList.remove("incomplete");

    if (this.checkboxTargets.length == 0) {
      this.countTarget.innerHTML = "";
      return;
    }

    const completedCount = this.checkboxTargets.filter(
      (cb) => cb.checked === true
    ).length;
    const taskCount = this.checkboxTargets.length;

    this.countTarget.innerHTML = `(${completedCount}/${taskCount})`;
    if (completedCount == taskCount) {
      this.cardTarget.classList.add("completed");
    } else {
      this.cardTarget.classList.add("incomplete");
    }
  }
}
