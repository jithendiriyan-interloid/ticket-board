import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel","icon","toggle"]
  toggle() {
    this.panelTarget.classList.toggle("-translate-x-full")
    this.iconTarget.classList.toggle("rotate-180")
<<<<<<< HEAD
<<<<<<< HEAD
    this.toggleTarget.classList.toggle("-right-10")
=======

>>>>>>> b1d0565 (sidebar collapse)
=======
    this.toggleTarget.classList.toggle("-right-10")
>>>>>>> 270f36d (sidebar toggle implemented)
  }
}

