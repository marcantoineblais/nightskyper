import { Controller } from "stimulus"
import mapboxgl from "mapbox-gl"


export default class extends Controller {
  static values = {
    apiKey: String,
    searchPath: String,
    bounds: Array,
    center: Array
  }

  connect() {
    console.log(document.getElementById('meteo'));
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    window.addEventListener("load", () => {
      window.dispatchEvent(new Event('resize'))
      this.#fitMapToBoundaries()
      this.#addMarkersToMap([this.centerValue], 'search-marker')
      this.map.on('moveend', () => {
        this.#getBoundariesCoordinates()
        this.#updateMarkers()
      })
    })

    this.map.on('click', (e) => {
      this.centerValue = [e.lngLat.lng, e.lngLat.lat]
      document.querySelector('.search-marker').outerHTML = ""
      this.#addMarkersToMap([this.centerValue], 'search-marker')
      this.#recenterMapToBondaries(this.centerValue)
    })
  }

  #addMarkersToMap(markers, cssClass) {
    markers.forEach((marker) => {
      const markerDiv = document.createElement('div');
      markerDiv.className = cssClass;
      new mapboxgl.Marker(markerDiv).setLngLat(marker).addTo(this.map)
    })
  }

  #fitMapToBoundaries() {
    const bounds = new mapboxgl.LngLatBounds(this.boundsValue)
    this.map.fitBounds(bounds, { padding: 15, maxZoom: 12, duration: 1000 })
  }

  #recenterMapToBondaries(marker) {
    const bounds = new mapboxgl.LngLatBounds([marker, marker])
    this.map.fitBounds(bounds, { zoom: this.map.getZoom(), duration: 1000 })
  }

  #getBoundariesCoordinates() {
    const bounds = this.map.getBounds()
    this.boundsValue = [bounds._ne.lng, bounds._ne.lat, bounds._sw.lng, bounds._sw.lat]
  }

  #updateMarkers() {
    fetch(this.searchPathValue, {
      method: "POST",
      headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" },
      body: JSON.stringify({
        map_boundaries: this.boundsValue,
        center: this.centerValue
      })
    })
    .then(res => res.json())
    .then((data) => {
      document.querySelectorAll('.pin-marker').forEach((marker) => {
        marker.outerHTML=""
      })
      this.#addMarkersToMap(data.map_markers, 'pin-marker')
    })
  }
}
