import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["checkbox", "checkboxAll"]

  connect() {
    console.log("hello formedit")
     {
      // console.log(this.checkboxAllTarget.childNodes[1].childNodes.slice)
      // console.log(this.checkboxTarget.childNodes)
      this.checkboxTarget.checked = true
      console.log(document.querySelectorAll('input:checked'))
    }
  }

  checker() {
      this.checkboxTarget.checked = true
  }
}
