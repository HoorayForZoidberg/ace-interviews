// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// require("chartkick")
// require("chart.js")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "../plugins/flatpickr"
// Internal imports, e.g:

import "select2/dist/css/select2.css"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

document.addEventListener('turbolinks:load', () => {
  const application = Application.start()
  const context = require.context("controllers", true, /_controller\.js$/)
  application.load(definitionsFromContext(context))
   Chartkick.eachChart( function(chart) {
    chart.redraw();
  });
});
