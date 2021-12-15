import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["checkbox", "checkboxAll", "button"]

  connect() {
    console.log("hello formeditpayment");
    console.log(document.getElementById("payment_montant_cents").value);

    if (document.querySelectorAll('input:checked').length < 2) {
      this.buttonTarget.firstElementChild.disabled = true
    }

  }

  checker() {

  // si              LONGUEUR < 2            ET             CHAMP VIDE
    if (document.querySelectorAll('input:checked').length < 2) {
      this.buttonTarget.firstElementChild.disabled = true
    } else {
      this.buttonTarget.firstElementChild.disabled = false
    }
  }

  remplir() {

    const isEmpty = str => !str.trim().length;

    if (isEmpty(document.getElementById("payment_montant_cents").value) || isEmpty(document.getElementById("payment_commentaire").value)) {
        this.buttonTarget.firstElementChild.disabled = true
      } else {
        this.buttonTarget.firstElementChild.disabled = false;
      }
  }




}
