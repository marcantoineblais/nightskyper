import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.urls = []

    this.widget = cloudinary.applyUploadWidget(
      this.element,
      {
        cloudName: 'diiu2j0fw',

        uploadPreset: 'nightskyper',
        cropping: true,
        folder: 'reviews',
        fieldName: 'review[photo]',
        croppingAspectRatio: 1.34,
        multiple: true,
        maxFiles: 6
      },
      (error, result) => {
        if (result.event == 'success') {
          this.urls.push(result.info.secure_url)
          this.element.value = this.urls
        }
      }
    )
  }
}
