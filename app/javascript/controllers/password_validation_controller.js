import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["password", "confirmation", "passwordFeedback", "confirmationFeedback", "submitButton"]

    connect() {
        // Verifica que los elementos necesarios estén presentes
        console.log("Password validation controller connected")
    }

    validatePassword() {
        const password = this.passwordTarget.value
        let isValid = true

        // Verificar longitud
        if (password.length < 8) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe tener al menos 8 caracteres'
            this.passwordFeedbackTarget.style.display = 'block'
            isValid = false
        }

        // Verificar mayúscula
        else if (!/[A-Z]/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos una letra mayúscula'
            this.passwordFeedbackTarget.style.display = 'block'
            isValid = false
        }

        // Verificar número
        else if (!/\d/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos un número'
            this.passwordFeedbackTarget.style.display = 'block'
            isValid = false
        }

        // Verificar símbolo
        else if (!/[^A-Za-z0-9]/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos un carácter especial'
            this.passwordFeedbackTarget.style.display = 'block'
            isValid = false
        }

        else {
            this.passwordTarget.classList.remove('is-invalid')
            this.passwordTarget.classList.add('is-valid')
            this.passwordFeedbackTarget.style.display = 'none'
        }

        this.checkPasswordMatch()
        return isValid
    }

    checkPasswordMatch() {
        if (this.hasPasswordTarget && this.hasConfirmationTarget) {
            const password = this.passwordTarget.value
            const confirmation = this.confirmationTarget.value

            if (password !== confirmation) {
                this.confirmationTarget.classList.add('is-invalid')
                this.confirmationFeedbackTarget.textContent = 'Las contraseñas no coinciden'
                this.confirmationFeedbackTarget.style.display = 'block'
                return false
            } else {
                this.confirmationTarget.classList.remove('is-invalid')
                this.confirmationTarget.classList.add('is-valid')
                this.confirmationFeedbackTarget.style.display = 'none'
                return true
            }
        }
        return true
    }

    validateForm(event) {
        const isPasswordValid = this.validatePassword()
        const doPasswordsMatch = this.checkPasswordMatch()

        if (!isPasswordValid || !doPasswordsMatch) {
            event.preventDefault()
        }
    }
}