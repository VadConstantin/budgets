import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    console.log("hello there")
  }

  checker() {
    if (document.querySelectorAll('input:checked').length > 2) {
      this.checkboxTarget.checked = false
    }
  }
}
