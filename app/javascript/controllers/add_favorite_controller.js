import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    path: String,
  }

  connect() {
    this.element.addEventListener('click', (e) => {
      console.log(this.pathValue);
      fetch(this.pathValue, {
        method: "POST",
        headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" }
      })
      .then(res => res.json())
      .then((data) => {
        if (data.saved) {
          this.element.parentElement.parentElement.parentElement.parentElement.parentElement.outerHTML = data.render
        } else {
          window.location.replace(data.render)
        }
      })
    })
  }
}