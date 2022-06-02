import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    'modalImg',
    'close',
    'modal',
    'img'
  ]

  connect() {
    this.imgTarget.addEventListener('click', (e) => {
      this.modalTarget.style.display = "block";
      this.modalImgTarget.src = this.imgTarget.src;
    })

    // When the user clicks on <span> (x), close the modal
    this.closeTarget.addEventListener('click', (e) => {
      this.modalTarget.style.display = "none";
    })
  }
}
