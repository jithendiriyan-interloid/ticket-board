import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.containerTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
    this.element.remove()
  }

  backdropClose(event) {
    if (event.target === this.containerTarget) {
      this.close()
    }
  }
}
