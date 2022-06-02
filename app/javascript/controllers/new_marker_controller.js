import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }

  connect() {
    document.getElementById('close-btn').addEventListener('click', (e) => {
      document.querySelector('body').style.overflow = "auto"
      this.element.style.display = "none"
    })
  }
}
