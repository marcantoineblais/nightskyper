import { Controller } from "stimulus"
import mapboxgl from "mapbox-gl"


export default class extends Controller {
  static values = {
    apiKey: String,
    bounds: Array,
    markers: Array,
    center: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    window.addEventListener("load", () => {
      window.dispatchEvent(new Event('resize'));
      if (this.markersValue) {
        this.#fitMapToBoundaries()
        this.#addMarkersToMap()
      }
    })

  }



  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker().setLngLat(marker).addTo(this.map)
    })
  }

  #fitMapToBoundaries() {
    const bounds = new mapboxgl.LngLatBounds(this.boundsValue)
    this.map.fitBounds(bounds, { padding: 15, maxZoom: 12, duration: 1000 })
  }
}
