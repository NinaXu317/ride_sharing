// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
// require("@rails/activestorage").start()
require("channels")
require("jquery")

//= require bootstrap-datetimepicker
//= require time_wrapper
//= require popper
//= require jquery.raty
//= require ratyrate
//= require bootstrap-sprockets
//= require flatpickr
//= require jquery
//= require rails-ujs
//= require moment
//= require moment/fr.js
//= require rails-ujs
//= require underscore
//= require gmaps/google
//= require_tree.

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "bootstrap";
import "controllers"
import 'bootstrap'

// ./packs/application.js
import { Application } from 'stimulus'
// import Flatpickr
import Flatpickr from 'stimulus-flatpickr'

import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))

// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr)

// google map
window.dispatchMapsEvent = function (...args) {
    const event = document.createEvent("Events")
    event.initEvent("google-maps-callback", true, true)
    event.args = args
    window.dispatchEvent(event)
};

$(document).on('turbolinks:load', function(){
    console.log('we are ready')

})

// Notification.requestPermission().then(function (result) {
//     console.log("get permission");
//     if (result.permission === 'denied') {
//         alert("Permission for notification is not granted!");
//     }
// })