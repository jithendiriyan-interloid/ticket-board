import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  connect() {
    this.panelTarget.classList.add("translate-x-full")

    requestAnimationFrame(() => {
      this.panelTarget.classList.remove("translate-x-full")
    })
  }

  close() {
    this.panelTarget.classList.add("translate-x-full")

    setTimeout(() => {
      document.getElementById("modal").innerHTML = ""
    })
  }

  backdropClose(event) {
    if (event.target === this.element) {
      this.close()
    }
  }
}