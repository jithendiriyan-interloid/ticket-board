import {Controller} from "@hotwired/stimulus"
export default class extends Controller {
    static targets=["menu"]
    connect() {
        this.handleOutsideClick=this.hide.bind(this)
        document.addEventListener("click",this.handleOutsideClick)
    }
    disconnect() {
        document.removeEventListener("click",this.handleOutsideClick)
    }
    toggle(event) {
        event.stopPropagation() 
        this.menuTarget.classList.toggle("hidden")
    }
    hide() {
        this.menuTarget.classList.add("hidden")
    }
}
