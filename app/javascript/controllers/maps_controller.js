import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["fieldStart", "fieldEnd", "map"]

  connect() {
    if (typeof (google) != "undefined"){
      this.initializeMap()
    }
  }

  initializeMap() {
    this.autocomplete()
    this.autocomplete2()
    console.log('init')
  }

  map() {
    if(this._map == undefined) {
      this._map = new google.maps.Map(this.mapTarget, {
        center: new google.maps.LatLng(
          39.5, -98.35
        ),
        zoom: 4
      })
    }
    return this._map
  }

  autocomplete() {
    if (this._autocomplete == undefined) {
      this._autocomplete = new google.maps.places.Autocomplete(this.fieldStartTarget)
    }
    return this._autocomplete
  }

  autocomplete2() {
    if (this._autocomplete2 == undefined) {
      this._autocomplete2 = new google.maps.places.Autocomplete(this.fieldEndTarget)
    }
    return this._autocomplete2
  }


  preventSubmit(e) {
    if (e.key == "Enter") { e.preventDefault() }
  }
}