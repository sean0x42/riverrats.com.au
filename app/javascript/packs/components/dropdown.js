/** @format */

import { closest } from "../util/DOMUtils";

/**
 * Toggles whether a generic dropdown is expanded or not.
 *
 * @example
 * toggleDropdown(element);
 *
 * @param {Element} dropdown Any child element of a dropdown.
 */
export function toggleDropdown(dropdown) {
  // Retrieve container and ensure it exists
  const container = closest(dropdown, ".dropdown__container");
  if (!container) {
    return;
  }

  // Toggle active state
  container.classList.toggle("dropdown__container--active");
  toggleOverlay(container);
}

/**
 * Toggles a dropdown container's overlay, if one exists.
 * @param {Element} container Dropdown container.
 */
function toggleOverlay(container) {
  // Ensure container has defined an overlay
  if (!container.hasAttribute("data-overlay")) {
    return;
  }

  // Toggle overlay
  const el = document.querySelector(container.getAttribute("data-overlay"));
  el.classList.toggle("dropdown__overlay--active");
}

/**
 * An event listener which fires whenever the document is clicked.
 * @param {Event} event Click event.
 * @private
 */
function handleDocumentClick(event) {
  const { target } = event;
  console.log(target);

  if (closest(target, ".dropdown__trigger") !== null) {
    toggleDropdown(target);
  }
}

document.addEventListener("click", handleDocumentClick);
