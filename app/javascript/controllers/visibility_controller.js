import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ 'hideable', 'radioButton' ]
    static values = { option: String }

    connect() {
        this.radioButtonTargets.forEach(radio => {
            radio.addEventListener('change', this.handleRadioButtonChange.bind(this))
        });
    }

    showTargets() {
        this.hideableTargets.forEach(el => {
            el.hidden = false
        });
    }

    hideTargets() {
        this.hideableTargets.forEach(el => {
            el.hidden = true
        });
    }

    toggleTargets() {
        this.hideableTargets.forEach((el) => {
            el.hidden = !el.hidden
        });
    }

    handleRadioButtonChange(event) {
        if (this.optionValue === event.target.value){
            this.showTargets()
        } else {
            this.hideTargets()
        }
    }
}