import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["radioGroup", "errorMessage", "submitButton"];

  connect() {
    // Attach the `change` event to all radio buttons in the group
    this.radioGroupTarget.addEventListener("change", () => {
      this.validate();
    });
  }
  
  validate(event) {
    // Check if at least one radio button is selected
    const checked = Array.from(this.radioGroupTarget.querySelectorAll("input[type='radio']")).some((radio) => radio.checked);

    if (!checked) {
      event.preventDefault();
      this.showErrorMessage();
    } else {
      this.clearErrorMessage();
      this.enableSubmitButton();
    }
  }

  showErrorMessage() {
    this.errorMessageTarget.textContent = "Debe seleccionar una opción.";
    this.errorMessageTarget.classList.add("d-inline");
    this.errorMessageTarget.classList.remove("d-none");
  }

  clearErrorMessage() {
    this.errorMessageTarget.textContent = "";
    this.errorMessageTarget.classList.remove("d-inline");
    this.errorMessageTarget.classList.add("d-none");
  }
  
  enableSubmitButton() {
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.removeAttribute("disabled");
    }
  }
}
