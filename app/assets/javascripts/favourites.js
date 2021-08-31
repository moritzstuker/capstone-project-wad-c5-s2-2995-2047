document.addEventListener("turbolinks:load", function () {

  // BUILD BUTTON
  // ————————————————————————————————————————————————————————————

  let triggerContainer = document.querySelector("#js-project-editbox");

  if (triggerContainer) {
    let starIcon = buildStarIcon();
    triggerContainer.insertBefore(starIcon, triggerContainer.firstChild);
  }

  // MANAGE FAVOURITES
  // ————————————————————————————————————————————————————————————

  // sets some useful variables
  let activeProjectId = window.location.pathname.split("/").pop();
  let trigger = document.querySelector("#js-favourite");
  let favourites = document.querySelector("#js-favourites-list");

  // Checks if current project is in favourites
  if (projectIsAlreadyInFavourites(activeProjectId)) {
    trigger.querySelector(".star").classList.add("filled");
  };

  if (trigger) {
    // Bind click event on button; once it's clicked, run addProjectToFavourites() function.
    trigger.addEventListener("click", function(event) {
      event.preventDefault();

      // build relevant urls
      let currentUrl = window.location.href
      let jsonUrl = currentUrl + ".json"

      // fetch json set up in rails controller
      fetch(jsonUrl)
      .then(response => response.json())
      .then(project => {

        // add url to object
        project.url = currentUrl;

        // check if project is already saved
        if (projectIsAlreadyInFavourites(project.id)) {
          removeProjectFromFavourites(project);
        } else {
          addProjectToFavourites(project);
        }
      })

      .catch(console.error);
    }, false);
  }

  function projectIsAlreadyInFavourites(projectId) {
    if (localStorage.getItem("favourites") !== null) {
      let currentFavourites = JSON.parse(localStorage.getItem("favourites"));
      return (currentFavourites.filter(function(e) { return String(e.id) === String(projectId); }).length > 0);
    } else {
      return false;
    }
  }

  function addProjectToFavourites(project) {
    // get current favourites or set (new) empty array
    let currentFavourites = JSON.parse(localStorage.getItem("favourites")) || [];

    // add project to array
    currentFavourites.push(project);

    // save array to localStorage
    localStorage.setItem("favourites", JSON.stringify(currentFavourites));

    // adds visual cue to icon
    trigger.querySelector(".star").classList.add("filled");
  }

  function removeProjectFromFavourites(project) {
    // get current favourites or set (new) empty array
    let currentFavourites = JSON.parse(localStorage.getItem("favourites"));

    // remove project frin array
    let newFavourites = currentFavourites.filter(function(e) { return e.id !== project.id; })

    // save array to localStorage
    localStorage.setItem("favourites", JSON.stringify(newFavourites));

    // removes visual cue from icon
    trigger.querySelector(".star").classList.remove("filled");
  }

  // POPULATE FAVORITES LIST
  // ————————————————————————————————————————————————————————————
  if (favourites) {
    // saves void image, just in case
    let voidImg = favourites.children[0];

    // if there are favourites, then ...
    if (favouritesExist()) {

      // clear the content
      favourites.innerHTML = "";
      let currentFavourites = JSON.parse(localStorage.getItem("favourites"));
      for (var i = 0; i < currentFavourites.length; i++) {
        favourites.appendChild(createChild(currentFavourites[i]));
      }
    }
  };

  function favouritesExist() {
    if (localStorage.getItem("favourites") !== null) {
      let currentFavourites = JSON.parse(localStorage.getItem("favourites"));
      return currentFavourites.length > 0;
    } else {
      return false;
    }
  }

  function buildStarIcon() {
    const starSpan = document.createElement('span');
    starSpan.setAttribute("id", "js-favourite");

    const starIconWrapper = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    starIconWrapper.setAttribute("xmlns", "http://www.w3.org/2000/svg");
    starIconWrapper.setAttribute("viewBox", "0 0 16 16");
    starIconWrapper.setAttribute("class", "icon star");

    const starIconPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
    starIconPath.setAttribute("d", "M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z");

    starIconWrapper.appendChild(starIconPath);
    starSpan.appendChild(starIconWrapper);

    return starSpan;
  }

  function createChild(project) {
    var boxRow = document.createElement('li');
    boxRow.classList.add('box-row');

    var nodeCard = document.createElement('div');
    nodeCard.classList.add('card');

    var nodeCardHeader = document.createElement('div');
    var nodeCardHeaderLink = document.createElement('a');
    var nodeCardHeaderText = document.createTextNode(project.label);
    nodeCardHeader.classList.add('card-header');
    nodeCardHeaderLink.href = project.url;
    nodeCardHeaderLink.appendChild(nodeCardHeaderText);
    nodeCardHeader.appendChild(nodeCardHeaderLink);

    var nodeCardContent = document.createElement('div');
    nodeCardContent.classList.add('card-content');
    if (project.description !== null) {
      var nodeCardContentText = document.createTextNode(project.description);
      nodeCardContent.appendChild(nodeCardContentText);
    }

    nodeCard.appendChild(nodeCardHeader);
    nodeCard.appendChild(nodeCardContent);

    boxRow.appendChild(nodeCard);

    return boxRow;
  }
});
