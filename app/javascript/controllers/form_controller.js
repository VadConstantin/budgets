// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    console.log("hello there")
  }

  checker() {

    console.log(this.checkboxTarget.checked)
    // console.log(this.checkboxTargets);

    // let checkboxes = document.querySelectorAll('input[type=checkbox]');
    // console.log(checkboxes);

    console.log(document.querySelectorAll('input:checked'))
  }

}
