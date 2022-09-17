import Flatpickr from 'stimulus-flatpickr'

// you can also import a translation file
import { Spanish } from 'flatpickr/dist/l10n/es.js'

// import a theme (could be in your main CSS entry too...)
import 'flatpickr/dist/flatpickr.css'

// create a new Stimulus controller by extending stimulus-flatpickr wrapper controller
export default class extends Flatpickr {
  initialize() {
    // sets your language (you can also set some global setting for all time pickers)
    this.config = {
      locale: Spanish
    }
  }
}