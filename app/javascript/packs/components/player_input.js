const SUGGESTIONS_WINDOW_CLASS = "suggestions-window";

let addedPlayers = [];

/**
 * Waits for the specified delay to expire before handling input.
 */
const delayInput = (() => {
  let timer = 0;
  return (callback, delay) => {
    clearTimeout(timer);
    timer = setTimeout(callback, delay);
  }
})();

/**
 * Retrieves a wrappers suggestion window, or creates one if it doesn't
 * already exist.
 * @param wrapper Parent wrapper.
 */
const getOrCreateSuggestionWindow = (wrapper) => {
  let window = wrapper.querySelector(`.${SUGGESTIONS_WINDOW_CLASS}`);

  // Construct new window
  if (window === null) {
    window = document.createElement("ul");
    window.classList.add(SUGGESTIONS_WINDOW_CLASS);
    wrapper.appendChild(window);
  }

  return window;
};

/**
 * Generates a suggestions window beside a field.
 * @param field Field to add suggestions to.
 * @param data Search data.
 */
const generateSuggestions = (field, data) => {
  const wrapper = field.parentNode;
  const suggestionWindow = getOrCreateSuggestionWindow(wrapper);

  // Clear children
  while (suggestionWindow.firstChild) {
    suggestionWindow.removeChild(suggestionWindow.firstChild);
  }

  // Handle no results
  if (data.length === 0) {
    const noResults = document.createElement("li");
    noResults.innerText = `Sorry! No matches for "${field.value}".`;
    suggestionWindow.appendChild(noResults);
    return;
  }

  // Create entry for each result
  for (let i = 0; i < data.length; i++) {
    // Create elements
    const result = data[i];
    const entry = document.createElement("li");
    entry.setAttribute("data-player-id", result["id"]);
    entry.innerText = `${result["full_name"]} ${result["username"]}`;
    suggestionWindow.appendChild(entry);
  }
};

/**
 * An event handler that is fired whenever a keyboard key ios released on
 * player inputs.
 * @param event Key up event.
 */
const onKeyUp = (event) => {
  const { target } = event;

  delayInput(() => {
    // noinspection JSUnresolvedFunction
    const baseUri = Routes.auto_complete_players_path({format: 'json'});

    // Clear suggestions if the field is empty
    if (target.value.length === 0) {
      const suggestionWindow = target.parentNode.querySelector(`.${SUGGESTIONS_WINDOW_CLASS}`);
      if (suggestionWindow !== null) {
        suggestionWindow.parentNode.removeChild(suggestionWindow);
      }
      return;
    }

    fetch(`${baseUri}?query=${target.value}`)
      .then(response => { return response.json(); })
      .then(data => generateSuggestions(target, data))
      .catch(error => console.error(error));
  }, 300);
};


/**
 * Checks the page for any player inputs, and initializes them.
 */
const checkForPlayerInputs = () => {
  const inputs = document.querySelectorAll("input.player-input:not([data-listening])");
  addedPlayers = [];

  // Initialised inputs
  inputs.forEach(input => {
    input.addEventListener("keyup", onKeyUp);
    input.setAttribute("data-listening", "true");
  });
};

addEventListener("turbolinks:load", checkForPlayerInputs);