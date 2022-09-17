import {Controller} from "@hotwired/stimulus";
import { Toast } from "bootstrap"

export default class extends Controller {
  connect() {
    let toast = new Toast(this.element)
    toast.show()
  }
}