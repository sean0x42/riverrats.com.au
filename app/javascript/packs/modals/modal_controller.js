import { Modal } from "./modal";

const modalQueue = [];
let currentlyDisplaying = false;

/**
 * Checks if a new modal should be displayed.
 */
const update = () => {
  if (currentlyDisplaying || modalQueue.length === 0) return;
  renderNextModal();
};

/**
 * Renders the next modal in the queue.
 */
const renderNextModal = () => {
  if (modalQueue.length === 0) return;

  // Construct wrapper
  const wrapper = document.createElement("div");
  wrapper.classList.add("modal-wrapper");
  document.body.appendChild(wrapper);

  // Construct inner wrapper
  const innerWrapper = document.createElement("div");
  innerWrapper.classList.add("wrapper");
  wrapper.appendChild(innerWrapper);

  // Construct modal
  const modal = document.createElement("div");
  modal.classList.add("modal");
  const m = modalQueue.pop();
  modal.innerHTML = `<span class="subheading">${m.subheading}</span><h1>${m.title}</h1>`;
  modal.innerHTML += m.html;
  innerWrapper.appendChild(modal);

  // Get or construct overlay
  const overlay = document.querySelector(".modal-overlay");
  overlay.setAttribute("active", "");
  currentlyDisplaying = true;
};

window.constructModal = (title, subheading, html) => {
  modalQueue.push(new Modal(title, subheading, html));
  update()
};

// Bind to ajax event
addEventListener("ajax:before", event => {
  const { target } = event;
  if (target.hasAttribute("data-expects-modal")) {
    document.querySelector(".modal-overlay").setAttribute("active", "");
    document.body.classList.add("no-scroll");
  }
});

addEventListener("click", event => {
  const { target } = event;
  if (currentlyDisplaying && (target.classList.contains("modal-wrapper") || target.classList.contains("modal-overlay"))) {
    currentlyDisplaying = false;
    const overlay = document.querySelector(".modal-overlay");
    const wrapper = document.querySelector(".modal-wrapper");
    overlay.removeAttribute("active");
    document.body.classList.remove("no-scroll");
    wrapper.parentNode.removeChild(wrapper);
  }
});