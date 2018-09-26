import { Flash } from "./components/flashes/flash";
import { Sortable } from "@shopify/draggable";
import { Player } from "./player/player";

const SORTABLE_CONF = {
  draggable: "li"
};

const queues = {
  player: [],
  referee: []
};

/**
 * Updates the positions of players according to the order they are defined in
 * the given array.
 * @param positions An array containing the ids of players in order.
 */
const updatePositions = (positions) => {
  const result = [];
  positions.forEach((key) => {
    let found = false;
    queues.player.filter((item) => {
      if (!found && item.id === key) {
        result.push(item);
        found = true;
        return true;
      } else {
        return false;
      }
    });
  });
  queues.player = result;
};

/**
 * Whether a particular queue contains a plsyer.
 * @param scope Queue to search.
 * @param id Target player id
 * @return {boolean} Whether the player was found.
 */
const contains = (scope, id) => {
  const queue = queues[scope];

  // Search for player
  for (let i = 0; i < queue.length; i++) {
    const player = queue[i];
    if (player.id === id) {
      return true;
    }
  }

  return false;
};

/**
 * Retrieves the given player and removes them. Returns null if not found.
 * @param scope Queue scope.
 * @param id Player id.
 */
const removePlayer = (scope, id) => {
  const queue = queues[scope];

  // Search for player
  for (let i = 0; i < queue.length; i++) {
    const player = queue[i];
    if (player.id === id) {
      queues[scope].splice(i, 1);
      return player;
    }
  }

  return null;
};

/**
 * An event handler that fires whenever a remove button is clicked.
 * @param event Button click event.
 */
const onRemoveClick = (event) => {
  const { target } = event;
  const listItem = target.parentNode;
  const player = removePlayer(
    listItem.getAttribute("data-scope"),
    listItem.getAttribute("data-player-id")
  );

  // Delete player
  if (!player.fresh) {
    console.log("TODO"); // TODO
  }

  updatePlayersList();
  updateRefereesList();
};

/**
 * Updates the given list to reflect the current state of the queue.
 * @param scope A queue of players to reflect.
 * @param list A list to redraw.
 * @param create A function which creates a single player.
 */
const update = (scope, list, create) => {
  const emptyState = list.querySelector(".empty-state");
  const players = list.querySelector(".players");

  // Handle empty state
  if (queues[scope].length === 0) {
    emptyState.style.display = "block";
    players.style.display = "none";
    return;
  }

  emptyState.style.display = "none";
  players.style.display = "block";

  // Remove pre-existing children
  while (players.firstChild) {
    players.removeChild(players.firstChild);
  }

  // Create players
  for (let i = 0; i < queues[scope].length; i++) {
    const element = create(queues[scope][i], i);
    element.setAttribute("data-scope", scope);
    players.appendChild(element);
  }
};

/**
 * Visually updates the players list to reflect the current state of the queue.
 */
const updatePlayersList = () => {
  // init
  const list = document.querySelector("#js-game-players");
  update("player", list, (player, position) => {
    // Create element
    const element = document.createElement("li");
    element.setAttribute("data-player-id", player.id);
    element.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="drag-handle"><path d="M11 18c0 1.1-.9 2-2 2s-2-.9-2-2 .9-2 2-2 2 .9 2 2zm-2-8c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0-6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm6 4c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg>`;
    element.appendChild(player.asElement());

    // Construct remove button
    const button = document.createElement("button");
    button.classList.add("player-remove");
    button.setAttribute("type", "button");
    button.addEventListener("click", onRemoveClick);
    button.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
    element.appendChild(button);

    // Construct id field
    const playerIdField = document.createElement("input");
    playerIdField.setAttribute("type", "hidden");
    playerIdField.setAttribute("name", `game[games_players_attributes][${player.uniqueId}][player_id]`);
    playerIdField.value = player.id;
    element.appendChild(playerIdField);

    // Construct position field
    const positionField = document.createElement("input");
    positionField.setAttribute("type", "hidden");
    positionField.setAttribute("name", `game[games_players_attributes][${player.uniqueId}][position]`);
    positionField.value = position;
    element.appendChild(positionField);

    // Construct destroy field
    const destroyField = document.createElement("input");
    destroyField.setAttribute("type", "hidden");
    destroyField.setAttribute("name", `game[games_players_attributes][${player.uniqueId}][_destroy]`);
    destroyField.value = false;
    element.appendChild(destroyField);

    return element;
  });
};

/**
 * Visually updates the referee (tournament director) list to reflect the current state of the queue.
 */
const updateRefereesList = () => {
  const list = document.querySelector("#js-game-referees");
  update("referee", list, (player) => {
    // Create element
    const element = document.createElement("li");
    element.setAttribute("data-player-id", player.id);
    element.appendChild(player.asElement());

    // Construct remove button
    const button = document.createElement("button");
    button.classList.add("player-remove");
    button.setAttribute("type", "button");
    button.addEventListener("click", onRemoveClick);
    button.innerHTML = `<svg class="material-icons" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
    element.appendChild(button);

    // Construct id field
    const playerIdField = document.createElement("input");
    playerIdField.setAttribute("type", "hidden");
    playerIdField.setAttribute("name", `game[referees_attributes][${player.uniqueId}][player_id]`);
    playerIdField.value = player.id;
    element.appendChild(playerIdField);

    // Construct destroy field
    const destroyField = document.createElement("input");
    destroyField.setAttribute("type", "hidden");
    destroyField.setAttribute("name", `game[referees_attributes][${player.uniqueId}][_destroy]`);
    destroyField.value = false;
    element.appendChild(destroyField);

    return element;
  });
};

/**
 * Searches for existing players and adds them to the appropriate queues.
 * @param scope Queue to add to.
 * @param selector Selector for the player list.
 */
const addExisting = (scope, selector) => {
  queues[scope] = [];
  const list = document.querySelector(selector);
  list.querySelectorAll("li[data-player]").forEach((item) => {
    const player = Player.fromJSON(item.getAttribute("data-player").replace(/\\/g, ""));
    queues[scope].push(player);
    item.removeAttribute("data-player");
  });
};

/**
 * Binds to various events.
 * @param input Input to bind to.
 * @param scope A queue of related elements.
 * @param updateFunc A function to update the queue.
 */
const bind = (input, scope, updateFunc) => {
  input.addEventListener("suggestion:select", (event) => {
    const player = event.detail;
    if (contains(scope, player.id)) {
      new Flash("error", "Player already added", `You've already added ${player.username} to this game.`).show();
      return;
    }

    queues[scope].push(player);
    updateFunc();
  });
};

/**
 * Binds to various sorting events.
 */
const initSortable = () => {
  // Init
  const list = document.querySelector(".js-sortable");
  const sortable = new Sortable(list, SORTABLE_CONF);

  // Bind
  sortable.on("sortable:stop", () => {
    // setTimeout(updatePositions, 10);
    const positions = [];
    Array.from(list.children).forEach((child) => {
      const id = child.getAttribute("data-player-id");
      if (!positions.includes(id)) {
        positions.push(id);
      }
    });
    updatePositions(positions);
  });
};

/**
 * Initialises the page by binding to event listeners (if relevant elements exist).
 */
const init = () => {
  // Handle game players
  const playerInput = document.querySelector("#js-game-players-input");
  if (playerInput !== null) {
    bind(playerInput, "player", updatePlayersList);
    initSortable();
    addExisting("player", "#js-game-players .players");
    updatePlayersList();
  }

  // Handle game referees
  const refereeInput = document.querySelector("#js-game-referees-input");
  if (refereeInput !== null) {
    bind(refereeInput, "referee", updateRefereesList);
    addExisting("referee", "#js-game-referees .players");
    updateRefereesList();
  }
};

document.addEventListener("turbolinks:load", init);
