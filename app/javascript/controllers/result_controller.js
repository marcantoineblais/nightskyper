import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "overviews", "predictions",
    "overview0", "overview1", "overview2", "overview3", "overview4", "overview5",
    "overview6", "prediction0", "prediction1", "prediction2", "prediction3", "prediction4",
     "prediction5", "prediction6"]

  connect() {
    this.overviewsTargets[0].style.display = 'block';
    this.predictionsTargets[0].style.display = 'none';
  }

  toggleOverviewPrediction(event) {
    console.log(event.currentTarget);
    this.overviewsTargets.forEach(element => {
      element.style.display = 'block';
      element.style.display = 'none';
    });
    this.predictionsTargets.forEach(element => {
      element.style.display = 'none';
      element.style.display = 'block';
    });
    const currentElementClick = event.currentTarget;
    const overviewOfCurrentElement = currentElementClick.parentElement.firstElementChild;
    const predictionOfCurrentElement = currentElementClick.parentElement.lastElementChild;
    console.log(overviewOfCurrentElement.classList);
    predictionOfCurrentElement.style.display = 'none';
    console.log(overviewOfCurrentElement);
    overviewOfCurrentElement.style.display = 'block';
    console.log(overviewOfCurrentElement);
  }

}
