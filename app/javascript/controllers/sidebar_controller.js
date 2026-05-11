import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel","icon"]

  open() {
    this.panelTarget.classList.remove("-translate-x-[220px]")
    this.iconTarget.classList.remove("rotate-180")
  }

  toggle() {
    this.panelTarget.classList.toggle("-translate-x-[220px]")
    this.iconTarget.classList.toggle("rotate-180")
  }
}