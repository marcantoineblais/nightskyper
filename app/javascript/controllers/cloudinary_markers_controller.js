import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.widget = cloudinary.applyUploadWidget(
      this.element,
      {
        cloudName: 'diiu2j0fw',
        uploadPreset: 'nightskyper',
        cropping: true,
        folder: 'markers',
        fieldName: 'marker[pic]',
        croppingAspectRatio: 1.6,
        multiple: false
      },
      (error, result) => {
        if (result.event == 'success') {
          if (document.querySelectorAll('li.cloudinary-thumbnail').length > 1) {
            document.querySelectorAll('li.cloudinary-thumbnail')[0].outerHTML = ""
          }
          this.url = (result.info.secure_url)
          this.element.value = this.url
        }
      }
    )
  }
}
