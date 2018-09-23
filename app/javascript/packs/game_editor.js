import { Flash } from "./components/flashes/flash";

let queues = {
  player: [],
  referee: []
};

/**
 * Whether a particular queue contains a plsyer.
 * @param q Queue to search.
 * @param id Target player id
 * @return {boolean} Whether the player was found.
 */
const contains = (q, id) => {
  const queue = queues[q];

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
 * Updates the given list to reflect the current state of the queue.
 * @param scope A queue of players to reflect.
 * @param list A list to redraw.
 * @param create A function which creates a single player.
 */
const update = (scope, list, create) => {
  const emptyState = list.querySelector(".empty-state");
  let players = list.querySelector("ul.players");

  // Handle empty state
  if (queues[scope].length === 0) {
    emptyState.style.display = "block";
    if (players != null) {
      players.parentNode.removeChild(players);
    }
    return;
  }

  emptyState.style.display = "none";

  // Create list if it doesn't exist
  if (players === null) {
    players = document.createElement("ul");
    players.classList.add("players");
    list.appendChild(players);
  } else {
    // Remove pre-existing children
    while (players.firstChild) {
      players.removeChild(players.firstChild);
    }
  }

  // Create players
  for (let i = 0; i < queues[scope].length; i++) {
    const player = queues[scope][i];
    players.appendChild(create(player));
  }
};

/**
 * Visually updates the players list to reflect the current state of the queue.
 */
const updatePlayersList = () => {
  // init
  const list = document.querySelector("#js-game-players");
  update("player", list, (player) => {
    // Create element
    const element = document.createElement("li");
    element.setAttribute("data-player-id", player.id);

    // Add player
    element.appendChild(player.asElement());

    // Construct remove button
    const button = document.createElement("button");
    button.classList.add("player-remove");
    button.setAttribute("type", "button");
    button.innerHTML = `<svg class="material-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
    element.appendChild(button);

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

    // Add player
    element.appendChild(player.asElement());

    // Construct remove button
    const button = document.createElement("button");
    button.classList.add("player-remove");
    button.setAttribute("type", "button");
    button.innerHTML = `<svg class="material-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
    element.appendChild(button);

    return element;
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
 * Initialises the page by binding to event listeners (if relevant elements exist).
 */
const init = () => {
  // Handle game players
  const playerInput = document.querySelector("#js-game-players-input");
  if (playerInput !== null) {
    bind(playerInput, "player", updatePlayersList);
  }

  // Handle game referees
  const refereeInput = document.querySelector("#js-game-referees-input");
  if (refereeInput !== null) {
    bind(refereeInput, "referee", updateRefereesList);
  }

  // Reset
  queues = {
    player: [],
    referee: []
  };
};

document.addEventListener("turbolinks:load", init);
