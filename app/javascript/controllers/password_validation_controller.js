// app/javascript/controllers/password_validation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["password", "confirmation", "passwordFeedback", "confirmationFeedback", "submitButton"]

    connect() {
        console.log("Password validation controller connected")
        console.log("Submit button:", this.submitButtonTarget)

        // Inicialmente deshabilitar el botón
        this.submitButtonTarget.disabled = true

        // Validar inmediatamente por si hay valores preexistentes
        this.validateForm()
    }

    validateForm() {
        // Obtener el estado de validación de los campos
        const isPasswordValid = this.validatePassword()
        const isConfirmationValid = this.checkPasswordMatch()

        // Log para depuración
        console.log("Password validation:", isPasswordValid, "Confirmation validation:", isConfirmationValid)

        // Habilitar o deshabilitar el botón según corresponda
        if (isPasswordValid && isConfirmationValid) {
            console.log("Habilitando botón")
            this.submitButtonTarget.disabled = false
        } else {
            console.log("Deshabilitando botón")
            this.submitButtonTarget.disabled = true
        }
    }

    validatePassword() {
        const password = this.passwordTarget.value

        // Resetear estado
        this.passwordTarget.classList.remove('is-valid', 'is-invalid')
        this.passwordFeedbackTarget.style.display = 'none'

        // Validar requisitos
        if (password.length < 8) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe tener al menos 8 caracteres'
            this.passwordFeedbackTarget.style.display = 'block'
            return false
        }

        if (!/[A-Z]/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos una letra mayúscula'
            this.passwordFeedbackTarget.style.display = 'block'
            return false
        }

        if (!/\d/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos un número'
            this.passwordFeedbackTarget.style.display = 'block'
            return false
        }

        if (!/[^A-Za-z0-9]/.test(password)) {
            this.passwordTarget.classList.add('is-invalid')
            this.passwordFeedbackTarget.textContent = 'La contraseña debe incluir al menos un carácter especial'
            this.passwordFeedbackTarget.style.display = 'block'
            return false
        }

        // Si pasa todas las validaciones
        this.passwordTarget.classList.add('is-valid')
        return true
    }

    checkPasswordMatch() {
        // Solo verificar coincidencia si hay contraseña
        if (!this.passwordTarget.value) {
            return false
        }

        const password = this.passwordTarget.value
        const confirmation = this.confirmationTarget.value

        // Resetear estado
        this.confirmationTarget.classList.remove('is-valid', 'is-invalid')
        this.confirmationFeedbackTarget.style.display = 'none'

        // Validar coincidencia
        if (!confirmation) {
            this.confirmationTarget.classList.add('is-invalid')
            this.confirmationFeedbackTarget.textContent = 'Por favor confirma tu contraseña'
            this.confirmationFeedbackTarget.style.display = 'block'
            return false
        }

        if (password !== confirmation) {
            this.confirmationTarget.classList.add('is-invalid')
            this.confirmationFeedbackTarget.textContent = 'Las contraseñas no coinciden'
            this.confirmationFeedbackTarget.style.display = 'block'
            return false
        }

        // Si coinciden
        this.confirmationTarget.classList.add('is-valid')
        return true
    }

    // Método de depuración (opcional)
    /**debug() {
        console.log({
            password: this.passwordTarget.value,
            passwordValid: this.validatePassword(),
            confirmation: this.confirmationTarget.value,
            confirmationValid: this.checkPasswordMatch(),
            buttonDisabled: this.submitButtonTarget.disabled
        })
    }**/
}