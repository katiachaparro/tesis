// https://github.com/stimulus-components/stimulus-rails-nested-form
import { Controller as n } from "@hotwired/stimulus";
class r extends n {
    add(t) {
        t.preventDefault();
        const e = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString());
        this.targetTarget.insertAdjacentHTML("beforebegin", e);
    }
    // Removes a nested form element
    remove(event) {
        event.preventDefault();

        // Find all existing wrappers (nested elements)
        const wrappers = this.element.querySelectorAll(this.wrapperSelectorValue);

        // Prevent removing the last remaining wrapper
        if (wrappers.length <= 1) {
            alert("Debes solicitar al menos un recurso");
            return;
        }

        // Find the specific wrapper to be removed
        const wrapper = event.target.closest(this.wrapperSelectorValue);

        // If it's a new record, simply remove it from the DOM
        if (wrapper.dataset.newRecord === "true") {
            wrapper.remove();
        } else {
            // Hide the existing wrapper and set the `_destroy` field to mark it for removal
            wrapper.style.display = "none";
            const destroyField = wrapper.querySelector("input[name*='_destroy']");
            if (destroyField) {
                destroyField.value = "1";
            }
        }
    }
}
r.targets = ["target", "template"];
r.values = {
    wrapperSelector: {
        type: String,
        default: ".nested-form-wrapper"
    }
};
export {
    r as default
};
