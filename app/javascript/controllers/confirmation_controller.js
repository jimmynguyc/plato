import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["elements"];

  confirm(event) {
    const message = this.elementsTarget?.dataset?.message;
    if (!window.confirm(message)) {
      event.preventDefault();
    }
  }
}
