import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    path: String,
  }

  connect() {
    console.log(this.pathValue)
    this.element.addEventListener('click', (e) => {
      fetch(this.pathValue, {
        method: "DELETE",
        headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" }
      })
      .then(res => res.json())
      .then((data) => {
        this.element.parentElement.parentElement.parentElement.parentElement.parentElement.outerHTML = data.render
      })
    })
  }
}
