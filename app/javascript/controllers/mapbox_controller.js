import { Controller } from "stimulus"
import mapboxgl from "mapbox-gl"


export default class extends Controller {
  static values = {
    apiKey: String,
    searchPath: String,
    customMarkerPath: String,
    bounds: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      pitch: 60,
      bearing: -60,
    })

    window.addEventListener("load", () => {
      window.dispatchEvent(new Event('resize'))
      }
    )

    this.#fitMapToBoundaries()
    this.map.doubleClickZoom.disable()

    this.map.on('moveend', () => {
      this.#getBoundariesCoordinates()
      this.#updateMarkers()
    })

    this.map.on('dblclick', (e) => {
      const coordinates = [e.lngLat.lng, e.lngLat.lat]
      fetch(this.customMarkerPathValue, {
        method: "POST",
        headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" },
        body: JSON.stringify({
          coordinates: coordinates
        })
      })
      .then(res => res.json())
      .then((data) => {
        console.log(data);
        if (document.querySelector('.search-marker')) {
          document.querySelector('.search-marker').outerHTML = ""
        }

        this.#addMarkersToMap([data.customMarker], 'search-marker')
        this.#recenterMapToBondaries(data.customMarker)

        if (document.getElementById('overview') && data.overview != document.getElementById('overview').outerHTML) {
          document.getElementById('overview').outerHTML = data.overview
        }
      })
    })
  }

  #addMarkersToMap(markers, cssClass) {
    markers.forEach((marker) => {
      const markerDiv = document.createElement('div');
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      markerDiv.className = cssClass;
      new mapboxgl.Marker(markerDiv).setLngLat([marker.lon, marker.lat]).setPopup(popup).addTo(this.map)
    })
  }

  #fitMapToBoundaries() {
    const bounds = new mapboxgl.LngLatBounds(this.boundsValue)
    this.map.fitBounds(bounds, { padding: 15, maxZoom: 12, duration: 1000 })
  }

  #recenterMapToBondaries(marker) {
    const bounds = new mapboxgl.LngLatBounds([marker.lon, marker.lat], [marker.lon, marker.lat])
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
        map_boundaries: this.boundsValue
      })
    })
    .then(res => res.json())
    .then((data) => {
      if (document.querySelectorAll('.pin-marker').length != 0) {
        document.querySelectorAll('.pin-marker').forEach((marker) => {
          marker.outerHTML=""
        })
      }
      this.#addMarkersToMap(data.mapMarkers, 'pin-marker')

      if (document.getElementById('marker-cards') && data.markerCards != document.getElementById('marker-cards').outerHTML) {
        document.getElementById('marker-cards').outerHTML = data.markerCards
      }
    })
  }
}
