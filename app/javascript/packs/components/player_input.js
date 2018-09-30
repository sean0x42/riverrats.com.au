import { createPlayerFromSearch } from "../player/player_controller";

const SUGGESTIONS_WINDOW_CLASS = "suggestions-window";

/**
 * Waits for the specified delay to expire before handling input.
 */
const delayInput = (() => {
  let timer = 0;
  return (callback, delay) => {
    clearTimeout(timer);
    timer = setTimeout(callback, delay);
  };
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
 * An event handler that is fired whenever you click on an entry.
 * @param event Click event
 */
const onEntryClick = (event) => {
  // Init
  const {target} = event;
  const wrapper = target.closest(".player-input-wrapper");

  // Make sure wrapper was found
  if (wrapper === null) {
    console.error("Catastrophic error: Failed to find input wrapper.");
    return;
  }

  // Finish initializing
  const suggestionWindow = wrapper.querySelector(".suggestions-window");
  const input = wrapper.querySelector("input.player-input");
  wrapper.dispatchEvent(new CustomEvent("suggestion:select", {
    bubbles: true,
    detail: target.closest("li").player
  }));

  // Clear
  input.value = "";
  suggestionWindow.parentNode.removeChild(suggestionWindow);
  input.focus();
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
    const player = createPlayerFromSearch(data[i]);
    const suggestion = document.createElement("li");
    suggestion.player = player;
    suggestion.appendChild(player.asElement());
    suggestion.addEventListener("click", onEntryClick);
    suggestionWindow.appendChild(suggestion);
  }
};

/**
 * An event handler that is fired whenever a keyboard key ios released on
 * player inputs.
 * @param event Key up event.
 */
const onKeyUp = (event) => {
  const {target} = event;

  delayInput(() => {
    // noinspection JSUnresolvedFunction
    const baseUri = Routes.auto_complete_players_path({format: "json"});

    // Clear suggestions if the field is empty
    if (target.value.length === 0) {
      const suggestionWindow = target.parentNode.querySelector(`.${SUGGESTIONS_WINDOW_CLASS}`);
      if (suggestionWindow !== null) {
        suggestionWindow.parentNode.removeChild(suggestionWindow);
      }
      return;
    }

    fetch(`${baseUri}?query=${target.value}`)
      .then((response) => { return response.json(); })
      .then((data) => generateSuggestions(target, data))
      .catch((error) => console.error(error));
  }, 300);
};


/**
 * Checks the page for any player inputs, and initializes them.
 */
window.checkForPlayerInputs = () => {
  const inputs = document.querySelectorAll("input.player-input:not([data-listening])");

  // Initialised inputs
  inputs.forEach((input) => {
    input.addEventListener("keyup", onKeyUp);
    input.setAttribute("data-listening", "true");
  });
};

addEventListener("turbolinks:load", checkForPlayerInputs);