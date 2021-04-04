// The Bulma package does not come with any JavaScript. Here is however an implementation example, which sets the click handler for Bulma delete all on the page, in vanilla JavaScript.
document.addEventListener('DOMContentLoaded', () => {
  (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
    const $notification = $delete.parentNode;

    $delete.addEventListener('click', () => {
      $notification.parentNode.removeChild($notification);
    });
  });
});

// // The following code is based off a toggle menu by @Bradcomp
// // source: https://gist.github.com/Bradcomp/a9ef2ef322a8e8017443b626208999c1
// (function() {
//   var burger = document.querySelector('.burger');
//   var menu = document.querySelector('#'+burger.dataset.target);
//   burger.addEventListener('click', function() {
//     burger.classList.toggle('is-active');
//     menu.classList.toggle('is-active');
//   });
// })();
