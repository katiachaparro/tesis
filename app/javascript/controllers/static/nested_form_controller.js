// https://github.com/stimulus-components/stimulus-rails-nested-form
import { Controller as n } from "@hotwired/stimulus";
class r extends n {
    add(t) {
        t.preventDefault();
        const e = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString());
        this.targetTarget.insertAdjacentHTML("beforebegin", e);
    }
    remove(t) {
        t.preventDefault();
        const e = t.target.closest(this.wrapperSelectorValue);
        if (e.dataset.newRecord === "true")
            e.remove();
        else {
            e.style.display = "none";
            const a = e.querySelector("input[name*='_destroy']");
            a.value = "1";
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
