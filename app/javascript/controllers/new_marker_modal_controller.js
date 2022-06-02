import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }

  connect() {
    document.getElementById('add-marker').addEventListener('click', (e) => {
      document.querySelector('body').style.overflow = "hidden"
      document.getElementById('marker-modal').style.display = "block"
    })
  }
}
