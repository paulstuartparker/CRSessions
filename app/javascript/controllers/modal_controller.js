import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.body.classList.add("modal-open")
  }

  disconnect() {
    document.body.classList.remove("modal-open")
  }

  close(event) {
    event.preventDefault()
    this.element.remove()
  }
} 