import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }
  static targets = ["modal"]

  connect() {
    console.log(this.modalTarget);

    const link = document.getElementById("add-marker")

    link.addEventListener("click", () => {
      this.modalTarget.classList.remove("d-none");
      this.modalTarget.style.display = "block"
    })
  }
}
