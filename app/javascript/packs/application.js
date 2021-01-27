// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import jQuery from "jquery"
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

document.addEventListener("turbolinks:load", function() {
  $('#toaster > .toast').toast('show');
  
  $('input:file[data-preview]').each(function() {
    const $img = $(`#${this.dataset.preview}`);
    if ($img.length) {
      const reader = new FileReader();
      reader.onload = function(e) {
        $img.attr('src', e.target.result);
      };
      
      $(this).on("change", function() {
        let file = this.files[0];
        if (file) reader.readAsDataURL(file);
      });
    }
  });
});

require("trix")
require("@rails/actiontext")
