import { Controller } from "stimulus"
import $ from "jquery"
import "select2"
import 'select2/dist/css/select2.css'
import 'select2-bootstrap-theme/dist/select2-bootstrap.min.css'

export default class extends Controller {
  connect() {
    let el = $(this.element)
    let parent = el.closest('.modal')

    if (parent.length > 0) {
      el.select2({ dropdownParent: parent, theme: "bootstrap", language: this.translateMessage() })
    } else {
      el.select2({ theme: "bootstrap", language: this.translateMessage() })
    }
  }

  translateMessage() {
    return {
      noResults: function () {
        return "Sin resultados";
      }
    }
  }
}