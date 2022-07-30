import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox", "button" ]

  connect() {
    console.log("hello thereeee")

    if (document.querySelectorAll('input:checked').length < 1) {
      this.buttonTarget.firstElementChild.disabled = true
    }
  }

  checker() {

    if (document.querySelectorAll('input:checked').length !== 1) {
      this.buttonTarget.firstElementChild.disabled = true
    } else {
      this.buttonTarget.firstElementChild.disabled = false
    }
  }
}
