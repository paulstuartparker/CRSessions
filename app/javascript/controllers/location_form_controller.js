import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["address", "city", "state", "zipCode", "latitude", "longitude"]

  connect() {
    if (typeof google === 'undefined') {
      setTimeout(() => this.initializeAutocomplete(), 1000)
    } else {
      this.initializeAutocomplete()
    }
  }

  initializeAutocomplete() {
    const autocomplete = new google.maps.places.Autocomplete(this.addressTarget, {
      componentRestrictions: { country: "us" },
      fields: ["address_components", "geometry"],
      types: ["address"]
    })

    autocomplete.addListener("place_changed", () => {
      const place = autocomplete.getPlace()
      this.fillInAddress(place)
    })
  }

  fillInAddress(place) {
    let street_number = ""
    let route = ""

    for (const component of place.address_components) {
      const type = component.types[0]
      switch (type) {
        case "street_number":
          street_number = component.long_name
          break
        case "route":
          route = component.long_name
          break
        case "locality":
          this.cityTarget.value = component.long_name
          break
        case "administrative_area_level_1":
          this.stateTarget.value = component.short_name
          break
        case "postal_code":
          this.zipCodeTarget.value = component.long_name
          break
      }
    }

    this.addressTarget.value = street_number + " " + route
    
    if (place.geometry?.location) {
      this.latitudeTarget.value = place.geometry.location.lat()
      this.longitudeTarget.value = place.geometry.location.lng()
    }
  }
} 