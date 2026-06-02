import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup"]

  show() {
    this.popupTarget.classList.remove("hidden")
  }

  hide() {
    this.popupTarget.classList.add("hidden")
  }
}