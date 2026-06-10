import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "removeField"]

  validate(event) {
    const file = event.target.files[0]
    if (!file) return
    const maxSize = 800 * 1024
    if (file.size > maxSize) {
      alert("Profile picture must be less than 800KB.")
      event.target.value = ""
      return
    }
    this.removeFieldTarget.value = "0"
    const reader = new FileReader()
    reader.onload = (e) => {
      this.imageTarget.src = e.target.result
    }
    reader.readAsDataURL(file)
  }
  remove() {
    this.imageTarget.src = "/default_avatar.jpg"
    this.removeFieldTarget.value = "1"
  }
}