import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  confirm(event) {
    const message = event.target.dataset?.message
    if(!window.confirm(message)){
      event.preventDefault()
    }
  }
}
