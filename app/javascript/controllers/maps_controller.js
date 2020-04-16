import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["fieldStart", "fieldEnd", "map"]

  connect() {
    if (typeof (google) != "undefined"){
      this.initializeMap()
    }
  }

  initializeMap() {
    this.map()
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
      this._autocomplete.bindTo('bounds', this.map())
      this._autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    }
    return this._autocomplete
  }

  autocomplete2() {
    if (this._autocomplete2 == undefined) {
      this._autocomplete2 = new google.maps.places.Autocomplete(this.fieldEndTarget)
      this._autocomplete2.bindTo('bounds', this.map())
      this._autocomplete2.setFields(['address_components', 'geometry', 'icon', 'name'])
    }
    return this._autocomplete2
  }


  preventSubmit(e) {
    if (e.key == "Enter") { e.preventDefault() }
  }
}