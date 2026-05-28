import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  validate(event) {
    const file = this.inputTarget.files[0]
    if (!file) return
    const maxSize = 800 * 1024 // 800KB
    if (file.size > maxSize) {
      this.inputTarget.value = ""
      return
    }
    this.upload(event)
  }
  upload(event) {
    event.target.closest("form").requestSubmit()
  }
}