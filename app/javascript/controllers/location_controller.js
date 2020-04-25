// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = ["map", "latitude", "longitude"]

//   connect() {
//     if (typeof (google) != "undefined"){
//       this.initializeMap()
//     }
//   }

//   initializeMap() {
//     this.map()
//     this.marker()
//     console.log('init')
//   }


//   map() {
//     if(this._map == undefined) {
//       this._map = new google.maps.Map(this.mapTarget, {
//         center: new google.maps.LatLng(
//           39.5, -98.35
//         ),
//         zoom: 4
//       })
//     }
//     return this._map
//   }

  

//   marker() {
//     if (this._marker == undefined) {
//       this._marker = new google.maps.Marker({
//         map: this.map(),
//         anchorPoint: new google.maps.Point(0,0)
//       })
//       let mapLocation = {
//         lat: parseFloat(this.latitudeTarget.value),
//         lng: parseFloat(this.longitudeTarget.value)
//       }
//       this._marker.setPosition(mapLocation)
//       this._marker.setVisible(true)
//     }
//     return this._marker
//   }


//   preventSubmit(e) {
//     if (e.key == "Enter") { e.preventDefault() }
//   }
// }