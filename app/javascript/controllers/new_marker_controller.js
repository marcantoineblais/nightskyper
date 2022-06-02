import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }
  static targets = ["modal", 'btn']

  connect() {
    console.log('hello');

    this.btnTarget.addEventListener('click', (e) => {
      this.body = document.querySelector('body')
      this.modalTarget.style.display = "block";
      this.body.insertAdjacentHTML("beforeend", this.modalTarget.outerHTML)
      this.modalTarget.outerHTML = ""
      document.querySelector('#close')('click', (e) => {
        document.querySelector('.modal').style.display = 'none'
        document.querySelector('body').outerHTML = this.body.outerHTML
      })
    })
  }
}
