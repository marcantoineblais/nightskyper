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
        folder: 'users',
        croppingAspectRatio: 1,
        fieldName: 'user[photo]',
        multiple: false
      },
      (error, result) => {
        console.log(error, result)
      }
    )
  }
}
