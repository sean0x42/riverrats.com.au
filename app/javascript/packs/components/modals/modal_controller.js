import { Modal } from "./modal";
import { State } from "./state";

let state = State.NONE;
const queue = [];

/**
 * Checks if there is a new modal in the queue to display. If there is, the state is updated appropriately and the new
 * modal is displayed.
 */
const updateModalQueue = () => {
  if (state === State.DISPLAYING_MODAL || queue.length === 0) return;
  renderModal(queue.shift());
  document.querySelector(".modal-loader").removeAttribute("active");
  state = State.DISPLAYING_MODAL;
};


/**
 * Renders the given model in the DOM.
 * @param modal Modal to render.
 */
const renderModal = (modal) => {
  // Construct wrapper
  const wrapper = document.createElement("div");
  wrapper.classList.add("modal-wrapper");
  document.body.appendChild(wrapper);

  // Construct inner wrapper
  const innerWrapper = document.createElement("div");
  innerWrapper.classList.add("wrapper");
  wrapper.appendChild(innerWrapper);

  // Construct modal
  const modalElement = document.createElement("div");
  modalElement.classList.add("modal");

  // Add subheading if one was defined
  if (modal.subheading !== null) {
    modalElement.innerHTML += `<span class="subheading">${modal.subheading}</span>`;
  }

  // Add title, if one was defined.
  if (modal.title !== null) {
    modalElement.innerHTML += `<h1>${modal.title}</h1>`;
  }

  modalElement.innerHTML += modal.html;
  innerWrapper.appendChild(modalElement);

  // Enable overlay, if it is not yet enabled
  const overlay = document.querySelector(".modal-overlay");
  overlay.setAttribute("active", "");
};

/**
 * @return {boolean} Whether the modal can currently be closed.
 */
const isCloseable = () => {
  return state === State.AWAITING_MODAL || state === State.DISPLAYING_MODAL;
};

/**
 * Closes the currently displayed modal (assuming there is one).
 */
const closeCurrentModal = () => {
  // Ensure there is actually a modal to close
  if (!isCloseable()) return;

  // Close modal
  const overlay = document.querySelector(".modal-overlay");
  const wrapper = document.querySelector(".modal-wrapper");
  document.body.classList.remove("no-scroll");
  overlay.removeAttribute("active");

  if (wrapper !== null)
    wrapper.parentNode.removeChild(wrapper);

  // Update state
  state = State.NONE;
  updateModalQueue();
};

/**
 * Creates a modal with the given information.
 * @param title Modal title.
 * @param subheading Modal subheading.
 * @param html Modal contents, as HTML.
 */
window.constructModal = (title, subheading, html) => {
  queue.push(new Modal(title, subheading, html));
  updateModalQueue();
  checkForDateFields();
  checkForSelects();
};

// Listen to ajax before event
addEventListener("ajax:before", (event) => {
  const { target } = event;

  // Handle clicks on model expecting links only
  if (target.hasAttribute("data-expects-modal") && state !== State.AWAITING_MODAL) {

    // Deal with currently displayed modals
    if (state === State.DISPLAYING_MODAL) {
      closeCurrentModal();
    }

    document.querySelector(".modal-loader").setAttribute("active", "");
    document.querySelector(".modal-overlay").setAttribute("active", "");
    document.body.classList.add("no-scroll");
    state = State.AWAITING_MODAL;
  }
});

// Listen to click event
addEventListener("click", (event) => {
  const { target } = event;
  if ((target.classList.contains("modal-wrapper") || target.classList.contains("modal-overlay")) && isCloseable()) {
    closeCurrentModal();
  }
});
