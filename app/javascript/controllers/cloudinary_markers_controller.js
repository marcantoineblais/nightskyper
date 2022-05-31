import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    console.log('Hello, Stimulus!')

    this.widget = cloudinary.applyUploadWidget(
      this.element,
      {
        cloudName: 'diiu2j0fw',
        uploadPreset: 'nightskyper',
        cropping: true,
        folder: 'markers',
        croppingAspectRatio: 1.6,
        fieldName: 'marker[photo]',
        multiple: false
      },
      (error, result) => {
        console.log(error, result)
      }
    )
  }
}
