import { Flash } from "./components/flashes/flash";

let playersQueue = [];

/**
 * Determines whether the player has already been queued up.
 * @param player Player to check for.
 * @returns {boolean} Whether the player has been queued.
 */
const playerQueueContains = (player) => {
  // Search for player
  for (let i = 0; i < playersQueue.length; i++) {
    const p = playersQueue[i];
    if (p.id === player.id) {
      return true;
    }
  }

  return false;
};

/**
 * Visually updates the players list to reflect the current state of the queue.
 */
const updatePlayersList = () => {
  // init
  const list = document.querySelector("#js-game-players");
  const emptyState = list.querySelector(".empty-state");
  let players = list.querySelector("ul.players");

  // Handle empty state
  if (playersQueue.length === 0) {
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
    // Remove children
    while (players.firstChild) {
      players.removeChild(players.firstChild);
    }
  }

  // Create players
  for (let i = 0; i < playersQueue.length; i++) {
    const player = playersQueue[i];
    const element = document.createElement("li");
    element.setAttribute("data-player-id", player.id);

    // Add player
    element.appendChild(player.asElement());

    // Construct remove button
    const button = document.createElement("button");
    button.classList.add("player-remove");
    button.innerHTML = `<svg class="material-icons" version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
    element.appendChild(button);

    players.appendChild(element);
  }
};

/**
 * Binds to various events on the standard player input.
 * @param input Input wrapper to bind to.
 */
const bindToPlayerInput = (input) => {
  input.addEventListener("suggestion:select", (event) => {
    const { detail } = event;

    // Check if the player has already been added
    if (playerQueueContains(detail)) {
      new Flash("error", "Player already added", `You've already added ${detail.username} to this game.`).show();
      return;
    }

    playersQueue.push(detail);
    updatePlayersList();
  }, false);
};

/**
 * Initialises the page by binding to event listeners (if relevant elements exist).
 * @param event Tubrolinks load event.
 */
const init = (event) => {
  const playerInput = document.querySelector("#js-game-players-input");
  if (playerInput !== null) {
    bindToPlayerInput(playerInput);
  }

  playersQueue = [];
};

document.addEventListener("turbolinks:load", init);
