import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox", "button" ]

  connect() {
    console.log("hello there")
    if (document.querySelectorAll('input:checked').length < 2) {
      this.buttonTarget.firstElementChild.disabled = true
    }
  }

  checker() {

    if (document.querySelectorAll('input:checked').length > 2) {
      this.checkboxTarget.checked = false
    }

    if (document.querySelectorAll('input:checked').length < 2) {
      this.buttonTarget.firstElementChild.disabled = true
    } else {
      this.buttonTarget.firstElementChild.disabled = false
    }
  }
}
