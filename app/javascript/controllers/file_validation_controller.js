import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  validate() {
    const maxSizeInBytes = 5 * 1024 * 1024; // 5 MB
    const files = this.inputTarget.files;

    for (let i = 0; i < files.length; i++) {
      if (files[i].size > maxSizeInBytes) {
        alert(`La imagen "${files[i].name}" excede el tamaño máximo de 5 MB.`);
        this.inputTarget.value = "";
        return;
      }
    }
  }
}