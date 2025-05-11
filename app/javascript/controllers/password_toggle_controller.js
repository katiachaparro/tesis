// app/javascript/controllers/password_toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "showIcon", "hideIcon"]

    connect() {
        // Asegurarse de que los iconos estén en el estado correcto al inicio
        this.showIconTarget.classList.remove('d-none')
        this.hideIconTarget.classList.add('d-none')
    }

    toggle() {
        if (this.inputTarget.type === 'password') {
            this.inputTarget.type = 'text'
            this.showIconTarget.classList.add('d-none')
            this.hideIconTarget.classList.remove('d-none')
        } else {
            this.inputTarget.type = 'password'
            this.showIconTarget.classList.remove('d-none')
            this.hideIconTarget.classList.add('d-none')
        }
    }
}