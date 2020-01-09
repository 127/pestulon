// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// TODO https://www.youtube.com/watch?reload=9&v=Hz8d6zPDSrk
// https://bibwild.wordpress.com/2019/08/01/dealing-with-legacy-and-externally-loaded-code-in-webpacker/

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

document.addEventListener("turbolinks:load", () => {
// $ ->
//   $("input.datepicker").each (i) ->
//     $(this).datepicker
//       altFormat: "dd-mm-yy"
//       dateFormat: "yy-mm-dd"
//       altField: $(this).next()
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
