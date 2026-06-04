import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  validate(event) {
    const file = event.target.files[0]
    if (!file) return
    const maxSize = 800 * 1024 // 800KB
    if (file.size > maxSize) {
      alert("Profile picture must be less than 800KB.")
      event.target.value = ""
      return
    }
    event.target.form.requestSubmit()
  }
}