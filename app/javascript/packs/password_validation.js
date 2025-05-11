// app/javascript/packs/password_validation.js
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('password-form');
    if (!form) return; // Si no existe el formulario, salir

    const passwordInput = document.getElementById('password');
    const confirmInput = document.getElementById('password_confirmation');
    const passwordFeedback = document.getElementById('password-feedback');
    const confirmFeedback = document.getElementById('confirmation-feedback');

    // Función para validar la contraseña
    function validatePassword() {
        const password = passwordInput.value;

        // Verificar longitud
        if (password.length < 8) {
            passwordInput.classList.add('is-invalid');
            passwordFeedback.textContent = 'La contraseña debe tener al menos 8 caracteres';
            passwordFeedback.style.display = 'block';
            return false;
        }

        // Verificar mayúscula
        if (!/[A-Z]/.test(password)) {
            passwordInput.classList.add('is-invalid');
            passwordFeedback.textContent = 'La contraseña debe incluir al menos una letra mayúscula';
            passwordFeedback.style.display = 'block';
            return false;
        }

        // Verificar número
        if (!/\d/.test(password)) {
            passwordInput.classList.add('is-invalid');
            passwordFeedback.textContent = 'La contraseña debe incluir al menos un número';
            passwordFeedback.style.display = 'block';
            return false;
        }

        // Verificar símbolo
        if (!/[^A-Za-z0-9]/.test(password)) {
            passwordInput.classList.add('is-invalid');
            passwordFeedback.textContent = 'La contraseña debe incluir al menos un carácter especial';
            passwordFeedback.style.display = 'block';
            return false;
        }

        passwordInput.classList.remove('is-invalid');
        passwordInput.classList.add('is-valid');
        passwordFeedback.style.display = 'none';
        return true;
    }

    // Función para verificar coincidencia
    function checkPasswordMatch() {
        if (passwordInput.value !== confirmInput.value) {
            confirmInput.classList.add('is-invalid');
            confirmFeedback.textContent = 'Las contraseñas no coinciden';
            confirmFeedback.style.display = 'block';
            return false;
        } else {
            confirmInput.classList.remove('is-invalid');
            confirmInput.classList.add('is-valid');
            confirmFeedback.style.display = 'none';
            return true;
        }
    }

    // Validar al cambiar la contraseña
    passwordInput.addEventListener('input', validatePassword);
    passwordInput.addEventListener('blur', validatePassword);

    // Comprobar coincidencia cuando se modifique cualquiera de los campos
    passwordInput.addEventListener('input', checkPasswordMatch);
    confirmInput.addEventListener('input', checkPasswordMatch);
    confirmInput.addEventListener('blur', checkPasswordMatch);

    // Validar antes de enviar el formulario
    form.addEventListener('submit', function(event) {
        const isPasswordValid = validatePassword();
        const doPasswordsMatch = checkPasswordMatch();

        if (!isPasswordValid || !doPasswordsMatch) {
            event.preventDefault();
        }
    });
});