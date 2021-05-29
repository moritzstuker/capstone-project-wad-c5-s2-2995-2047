// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require particles
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  // header dropdown
  let dropdowns = document.querySelectorAll(".dropdown");
  dropdowns.forEach(function(e) {
    e.addEventListener("click", () => {
      let s = e.classList.contains("is-closed");
      dropdowns.forEach(e => e.classList.add("is-closed")), s && e.classList.remove("is-closed")
    })
  });

  // deadline buttons
  document.querySelectorAll(".deadlines td .button").forEach(function(e) {
    e.addEventListener("click", () => {
      e.closest("tr").classList.toggle("disabled")
    })
  });

  // flash notification
  document.querySelectorAll(".flash-close").forEach(function(e) {
    e.addEventListener("click", () => {
      e.parentNode.remove();
    })
  });
});
