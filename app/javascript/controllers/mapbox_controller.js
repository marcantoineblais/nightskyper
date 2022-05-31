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
    })

    // Resize the map after page load (solve display bug)
    window.addEventListener("load", () => {
      window.dispatchEvent(new Event('resize'))
    })

    this.#fitMapToBoundaries()
    this.#updateMarkers()
    // fit the map to the boundaries
    // When done moving, load the markers
    this.map.doubleClickZoom.disable()
    this.map.on('moveend', () => {
      this.#getBoundariesCoordinates()
      this.#updateMarkers()
    })

    // add custom marker on double click
    this.map.on('dblclick', (e) => {
      const coordinates = [e.lngLat.lng, e.lngLat.lat]
      this.#updateCustomMarker(coordinates)
    })
  }

  #addMarkersToMap(markers, cssClass) {
    // after search, show the first batch of markers from that given location
    // if the marker is not a custom marker :
    // - on marker click, recenter the map aroung marker
    // - load the surrounding markers with new boundaries
    // - adjust the zoom level on that marker (3 levels)
    // - remove custom marker if one was pinned
    // - update the page with infos from the current location

    markers.forEach((marker) => {
      const markerDiv = document.createElement('div');
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      markerDiv.className = cssClass;
      const mapMarker = new mapboxgl.Marker(markerDiv)
    .setLngLat([marker.lon, marker.lat])
    .setPopup(popup)
    .addTo(this.map)

    if (cssClass == 'pin-marker') {
      mapMarker.getElement().addEventListener('click', (e) => {
        this.#getMarkerInfos([marker.lon, marker.lat])
      })
    }})
  }

  #fitMapToBoundaries() {
    // fit the map with the given boundaries and adjust zoom level

    const bounds = new mapboxgl.LngLatBounds(this.boundsValue)
    console.log(bounds)
    this.map.fitBounds(bounds, { padding: 0, duration: 0 })
  }

  #recenterMapToBondaries(marker, zoom) {
    // when clicking or pinning a marker, recenter the map aroung that marker by creating new boundaries

    const bounds = new mapboxgl.LngLatBounds([marker.lon, marker.lat], [marker.lon, marker.lat])
    this.map.fitBounds(bounds, { zoom: zoom, duration: 1000 })
  }

  #getBoundariesCoordinates() {
    // ask the map for its current boundaries

    const bounds = this.map.getBounds()
    this.boundsValue = [bounds._ne.lng, bounds._ne.lat, bounds._sw.lng, bounds._sw.lat]
  }

  #updateMarkers() {
    // when navigating in the map, dynamicly load the visible markers
    // remove the markers that are not visible anymore

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

      if (document.getElementById('marker-cards') && data.markerCards != document.getElementById('marker-cards').innerHTML) {
        document.getElementById('marker-cards').innerHTML = data.markerCards
      }
    })
  }

  #updateCustomMarker(coordinates) {
    // when pinning a new custom marker, remove the old one
    // recenter the map and update the page accordingly

    fetch(this.customMarkerPathValue, {
      method: "POST",
      headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" },
      body: JSON.stringify({
        coordinates: coordinates
      })
    })
    .then(res => res.json())
    .then((data) => {
      if (document.querySelector('.search-marker')) {
        document.querySelector('.search-marker').outerHTML = ""
      }
      const zoom = this.map.getZoom()
      this.#recenterMapToBondaries(data.customMarker, zoom)
      this.#addMarkersToMap([data.customMarker], 'search-marker')

      if (document.getElementById('overview') && data.overview != document.getElementById('overview').outerHTML) {
        document.getElementById('overview').outerHTML = data.overview
      }
    })
  }

  #getMarkerInfos(coordinates) {
  // get the popup and coordinates of the updated markers visible on the map.
  // control the zoom level when clicking same marker multiple times

    fetch(this.customMarkerPathValue, {
      method: "POST",
      headers: { "Content-Type": "application/json", "Accept": "application/json", charset: "UTF-8" },
      body: JSON.stringify({
        coordinates: coordinates
      })
    })
    .then(res => res.json())
    .then((data) => {
      if (document.querySelector('.search-marker')) {
        document.querySelector('.search-marker').outerHTML = ""
      }

      let zoom
      if (this.map.getZoom() < 12) {
        zoom = 12
      } else if (this.map.getZoom() < 16) {
        zoom = 16
      } else if (this.map.getZoom() < 18) {
        zoom = 18
      } else {
        zoom = this.map.getZoom()
      }

      this.#recenterMapToBondaries(data.customMarker, zoom)

      if (document.getElementById('overview') && data.overview != document.getElementById('overview').outerHTML) {
        document.getElementById('overview').outerHTML = data.overview
      }
    })
  }
}
