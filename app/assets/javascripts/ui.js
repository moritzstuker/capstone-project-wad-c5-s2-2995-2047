document.addEventListener("turbolinks:load", function () {
  // Closes all other 'detail' tags when clicking on one
  const details = document.querySelectorAll("details");
  details.forEach((targetDetail) => {
    targetDetail.addEventListener("click", () => {
      details.forEach((detail) => {
        if (detail !== targetDetail) {
          detail.removeAttribute("open");
        }
      });
    });
  });

  // Hides notifications upon clicking on the button
  document.querySelectorAll(".flash-close").forEach(function (e) {
    e.addEventListener("click", function () {
      e.parentNode.remove();
    });
  });

  // Search form interactivity
  var searchForm = document.getElementById('search-form');
  if (document.body.contains(searchForm)) {
    var searchInput = document.getElementById('query');
    var expandedSearch = document.getElementById('expanded-search');
    searchInput.addEventListener("keyup", function () {
      if (searchInput.value) {
        searchForm.classList.add("expanded");
        expandedSearch.style.maxHeight = expandedSearch.scrollHeight + 'px';
        document.querySelectorAll(".search-value").forEach(function (e) {
          e.innerText = searchInput.value;
        });
      } else {
        searchForm.classList.remove("expanded");
        expandedSearch.style.maxHeight = '';
      }
    });
  }
});
