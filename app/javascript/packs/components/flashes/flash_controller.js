import { Flash } from "./flash";

/**
 * Constructs a new flash element.
 * @param flash Flash object.
 * @return {HTMLElement} A new flash element.
 * @private
 */
function createFlash(flash) {
  const element = document.createElement("div");
  element.classList.add("flash", `flash-${flash.type}`);

  // Construct icon
  const icon = document.createElement("div");
  icon.classList.add("flash-icon");
  icon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M4.47 21h15.06c1.54 0 2.5-1.67 1.73-3L13.73 4.99c-.77-1.33-2.69-1.33-3.46 0L2.74 18c-.77 1.33.19 3 1.73 3zM12 14c-.55 0-1-.45-1-1v-2c0-.55.45-1 1-1s1 .45 1 1v2c0 .55-.45 1-1 1zm1 4h-2v-2h2v2z"/></svg>`;
  element.appendChild(icon);

  // Construct inner content
  const inner = document.createElement("div");
  const title = document.createElement("h3");
  const body = document.createElement("p");
  inner.classList.add("flash-body");
  title.textContent = flash.title;
  body.textContent = flash.body;
  inner.appendChild(title);
  inner.appendChild(body);
  element.appendChild(inner);

  // Construct close button
  const button = document.createElement("button");
  button.classList.add("flash-close");
  button.innerHTML = `<svg class="material-icons" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24"><path d="M18.3,5.71L18.3,5.71c-0.39-0.39-1.02-0.39-1.41,0L12,10.59L7.11,5.7c-0.39-0.39-1.02-0.39-1.41,0l0,0c-0.39,0.39-0.39,1.02,0,1.41L10.59,12L5.7,16.89c-0.39,0.39-0.39,1.02,0,1.41h0c0.39,0.39,1.02,0.39,1.41,0L12,13.41l4.89,4.89c0.39,0.39,1.02,0.39,1.41,0l0,0c0.39-0.39,0.39-1.02,0-1.41L13.41,12l4.89-4.89C18.68,6.73,18.68,6.09,18.3,5.71z"></path></svg>`;
  element.appendChild(button);

  return element;
}


/**
 * Displays a flash message.
 * @param flash Flash message to display.
 */
export function renderFlashMessage(flash) {
  const flashes = document.querySelector(".flash-messages");
  flashes.appendChild(createFlash(flash));
}


// Catch and deal with clicks to close flashes
document.addEventListener("click", (event) => {
  const { target } = event;
  if (!target.classList.contains("flash-close")) return;
  const flash = target.closest(".flash");
  flash.parentNode.removeChild(flash);
});

/**
 * This is a very simple interface for creating a new flash message.
 * @param title Flash title.
 * @param body Flash body.
 */
window.createFlash = (title, body) => {
  new Flash("info", title, body).show();
};
