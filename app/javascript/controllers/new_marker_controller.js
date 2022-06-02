import { Controller } from "stimulus"

export default class extends Controller {
  static values = { coordinates: Array }
  static targets = ["modal"]

  connect() {
    // console.log(this.modalTarget);

    const link = document.getElementById("add-marker")
    const modal = this.modalTarget.cloneNode(true)

    link.addEventListener("click", () => {
      this.modalTarget.remove()
      document.body.insertAdjacentElement("afterbegin", modal)
      // modal.classList.remove("d-none");
      modal.style.display = "block"

    })
  }
}
