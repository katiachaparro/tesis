import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  connect() {
    console.log("Putttoooo")
    this.modal = new Modal(this.element)
    this.modal.show()
  }
  hideBeforeRender(event) {
    console.log("Putttoooo 2")
    if (this.isOpen()) {
      event.preventDefault()
      this.element.addEventListener('hidden.bs.modal', event.detail.resume)
      this.modal.hide()
    }
  }
  isOpen() {
    console.log("Putttoooo 3")
    return this.element.classList.contains('show')
  }
}