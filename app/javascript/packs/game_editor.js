import { Flash } from "./components/flashes/flash";
import { Sortable } from "@shopify/draggable";
import { Player } from "./player/player";

const SORTABLE_CONF = Object.freeze({
  draggable: "li"
});

const queues = {
  player: [],
  referee: []
};

/**
 * An event handler that fires whenever you click the remove button of a player.
 * @param event Click event.
 */
function onRemoveButtonClick(event) {
  const listItem = event.target.parentNode;
  remove(listItem.getAttribute("data-scope"), listItem.getAttribute("data-player-id"));
}

/**
 * Constructs a new HTML element, which represents a single player.
 * @param player Player to represent in HTML.
 * @return {HTMLElement} A HTML representation of the player.
 */
function constructPlayerElement(player) {
  // Create element
  const element = document.createElement("li");
  element.setAttribute("data-player-id", player.id);
  element.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="drag-handle"><path d="M11 18c0 1.1-.9 2-2 2s-2-.9-2-2 .9-2 2-2 2 .9 2 2zm-2-8c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0-6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm6 4c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>`;
  element.appendChild(player.asElement(1));

  // Construct remove button
  const button = document.createElement("button");
  button.classList.add("player-remove");
  button.setAttribute("type", "button");
  button.addEventListener("click", onRemoveButtonClick);
  button.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
  element.appendChild(button);

  // Construct position field
  const positionField = document.createElement("input");
  positionField.classList.add("js-position-field");
  positionField.setAttribute("type", "hidden");
  positionField.setAttribute("name", `game[games_players_attributes][${player.uniqueId}][position]`);
  positionField.value = 0;
  element.appendChild(positionField);

  return element;
}

/**
 * Constructs a new HTML element, which represents a single player.
 * @param player Player to represent in HTML.
 * @return {HTMLElement} A HTML representation of the player.
 */
function constructRefereeElement(player) {
  // Create element
  const element = document.createElement("li");
  element.setAttribute("data-player-id", player.id);
  element.appendChild(player.asElement());

  // Construct remove button
  const button = document.createElement("button");
  button.classList.add("player-remove");
  button.setAttribute("type", "button");
  button.addEventListener("click", onRemoveButtonClick);
  button.innerHTML = `<svg class="material-icons" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
  element.appendChild(button);

  return element;
}

/**
 * Constructs a new HTML element, which represents a player in a list.
 * @param scope Scope, either player or referee.
 * @param player Player to represent in HTML.
 * @return {HTMLElement} A HTML representation of the player.
 */
function constructElement(scope, player) {
  let element;
  let attributeName;

  // Construct
  if (scope === "player") {
    element = constructPlayerElement(player);
    attributeName = "games_players_attributes";
  } else {
    element = constructRefereeElement(player);
    attributeName = "referees_attributes";
  }

  element.setAttribute("data-fresh", "");
  element.setAttribute("data-scope", scope);

  // Construct id field
  const playerIdField = document.createElement("input");
  playerIdField.setAttribute("type", "hidden");
  playerIdField.setAttribute("name", `game[${attributeName}][${player.uniqueId}][player_id]`);
  playerIdField.value = player.id;
  element.appendChild(playerIdField);

  // Construct destroy field
  const destroyField = document.createElement("input");
  destroyField.classList.add("js-destroy-field");
  destroyField.setAttribute("type", "hidden");
  destroyField.setAttribute("name", `game[${attributeName}][${player.uniqueId}][_destroy]`);
  destroyField.value = false;
  element.appendChild(destroyField);

  return element;
}

/**
 * Determine whether a list contains an element. Returning it if found.
 * @param list List to search.
 * @param id Player id to look for.
 * @return The found element or null.
 */
function listContains(list, id) {
  return list.querySelector(`li[data-player-id="${id}"`);
}

/**
 * Adds a player to a specified queue.
 * @param scope Queue scope.
 * @param player Player to add.
 */
function add(scope, player) {
  // Add to queue
  queues[scope].push(player);

  // Determine if element already exists
  const list = document.querySelector(`.players[data-scope="${scope}"]`);
  let element = listContains(list, player.id);
  if (element === null) {
    element = constructElement(scope, player);
  }

  list.appendChild(element);

  // Show the list if necessary
  if (list.style.display === "none") {
    list.style.display = "block";
    list.previousElementSibling.style.display = "none";
  }
}

/**
 * Removes the given player
 * @param scope Queue scope.
 * @param id Player id.
 */
function remove(scope, id) {
  const queue = queues[scope];

  // Search for and remove player
  for (let i = 0; i < queue.length; i++) {
    const player = queue[i];
    if (player.id === id) {
      queues[scope].splice(i, 1);
      break;
    }
  }

  // Init
  const list = document.querySelector(`.players[data-scope="${scope}"]`);
  const element = listContains(list, id);

  // Hide list if necessary
  if (queue.length === 0) {
    list.style.display = "none";
    list.previousElementSibling.style.display = "block";
  }

  // Delete element if fresh
  if (element.hasAttribute("data-fresh")) {
    element.parentNode.removeChild(element);
    return;
  }

  // Hide element
  element.style.display = "none";
  const destroyField = element.querySelector(".js-destroy-field");
  destroyField.value = true;
}

/**
 * Whether a particular queue contains a player.
 * @param scope Queue to search.
 * @param id Target player id
 * @return {boolean} Whether the player was found.
 */
function contains(scope, id) {
  const queue = queues[scope];

  // Search for player
  for (let i = 0; i < queue.length; i++) {
    const player = queue[i];
    if (player.id === id) {
      return true;
    }
  }

  return false;
}

/**
 * An event handler that fires whenever a player is added.
 * @param event Player add event.
 */
function onPlayerAdd(event) {
  const player = event.detail;

  // Ensure player hasn't already been added.
  if (contains("player", player.id)) {
    new Flash("error", "Player already added", `You've already added ${player.username} to this game.`).show();
    return;
  }

  add("player", player);
}

/**
 * An event handler that fires whenever a referee is added.
 * @param event Referee add event.
 */
function onRefereeAdd(event) {
  const referee = event.detail;

  // Ensure referee hasn't already been added
  if (contains("referee", referee.id)) {
    new Flash("error", "Tournament director already added", `You've already added ${player.username} to this game.`).show();
    return;
  }

  add("referee", referee);
}

/**
 * An event handler that is fired whenever the form is submitted.
 * @param event Form submit event.
 */
function onSubmitForm(event) {
  // Init
  const { target } = event;
  const players = target.querySelector(".js-sortable");

  // Set positions
  let position = 0;
  players.querySelectorAll("li").forEach((player) => {
    // Get fields
    const positionField = player.querySelector(".js-position-field");
    const destroyField = player.querySelector(".js-destroy-field");

    // Set
    if (destroyField.value === true || destroyField.value === "true") {
      positionField.value = -1;
    } else {
      positionField.value = position;
      position++;
    }
  });
}

/**
 * Searches for existing players, then adds them to the appropriate queue.
 * @param scope Queue to add to.
 * @param selector Selector for the player list.
 */
function addExistingPlayers(scope, selector) {
  // init
  const list = document.querySelector(selector);
  queues[scope] = [];

  // Retrieve existing players
  list.querySelectorAll("li[data-player]").forEach((item) => {
    // Parse and add player
    const player = Player.fromJSON(item.getAttribute("data-player").replace(/\\/g, ""));
    queues[scope].push(player);
    item.removeAttribute("data-player");

    // Add on remove event
    const removeButton = item.querySelector("button.player-remove");
    removeButton.addEventListener("click", onRemoveButtonClick);
  });
}

/**
 * Initialises sortable on the players list.
 */
function initialiseSortable() {
  const list = document.querySelector(".js-sortable");
  new Sortable(list, SORTABLE_CONF);
}

/**
 * Initialises the game editor.
 */
function initialise() {
  // Handle game players
  const playerInput = document.querySelector("#js-game-players-input");
  if (playerInput !== null) {
    playerInput.addEventListener("suggestion:select", onPlayerAdd);
    initialiseSortable();
    addExistingPlayers("player", "#js-game-players .players");
    playerInput.closest("form").addEventListener("submit", onSubmitForm);
  }

  // Handle game referees
  const refereeInput = document.querySelector("#js-game-referees-input");
  if (refereeInput !== null) {
    refereeInput.addEventListener("suggestion:select", onRefereeAdd);
    addExistingPlayers("referee", "#js-game-referees .players");
  }
}

document.addEventListener("turbolinks:load", initialise);
