import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number,
    name: String
  }

  connect() {
    this.initializeMap()
  }

  initializeMap() {
    const map = new google.maps.Map(this.element, {
      center: { lat: this.latitudeValue, lng: this.longitudeValue },
      zoom: 15,
      styles: [/* Add custom map styles here */]
    })

    new google.maps.Marker({
      position: { lat: this.latitudeValue, lng: this.longitudeValue },
      map,
      title: this.nameValue
    })
  }
} 