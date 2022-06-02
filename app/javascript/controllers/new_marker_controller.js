import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }
  static targets = ["modal", "close", 'btn']

  connect() {
    console.log('hello');

    this.btnTarget.addEventListener('click', (e) => {
      this.body = document.querySelector('body')
      this.modalTarget.style.display = "block";
      this.body.insertAdjacentHTML("afterbegin", this.modalTarget.outerHTML)
      this.modalTarget.outerHTML = ""
    })

    this.modalTarget.addEventListener('click', (e) => {
      this.modalTarget.style.display = "none"
      document.querySelector('body').outerHTML = this.body.outerHTML
    })
  }
}
