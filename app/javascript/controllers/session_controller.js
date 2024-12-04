import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recurrenceOptions"]

  toggleRecurrence(event) {
    if (event.target.checked) {
      this.recurrenceOptionsTarget.classList.remove("hidden")
    } else {
      this.recurrenceOptionsTarget.classList.add("hidden")
    }
  }
} 