let dropdownOverlay;
let activeDropdown = null;

/**
 * Shows the given dropdown menu.
 * @param wrapper Dropdown wrapper to enable.
 */
const enableDropdown = wrapper => {
  // Disable current dropdown
  if (activeDropdown != null) {
    disableDropdown(activeDropdown);
  }

  // Enable
  dropdownOverlay.setAttribute("active", "");
  wrapper.setAttribute("active", "");
  activeDropdown = wrapper;
};

/**
 * Disables a given dropdown (assuming it is enabled).
 * @param wrapper Dropdown wrapper to disable.
 */
const disableDropdown = wrapper => {
  wrapper.removeAttribute("active");
  dropdownOverlay.removeAttribute("active");
  activeDropdown = null;
};

/**
 * An event handler that is fired whenever the mouse enters a dropdown trigger.
 * @param event Mouse enter event.
 */
const onTriggerMouseEnter = event => {
  const { target } = event;
  enableDropdown(target.parentNode);
};

/**
 * An event handler that is fired whenever the mouse leaves a dropdown.
 * @param event Mouse leave event.
 */
const onDropdownMouseLeave = event => {
  const { target } = event;
  disableDropdown(target.parentNode);
};

/**
 * Binds to various events on a dropdown wrapper.
 * @param wrapper Wrapper to bind to.
 */
const bindToWrapperEvents = wrapper => {

  // Retrieve children
  const trigger = wrapper.children[0];
  const dropdown = wrapper.children[1];

  // Bind to events
  trigger.addEventListener("mouseenter", onTriggerMouseEnter);
  dropdown.addEventListener("mouseleave", onDropdownMouseLeave);
};

/**
 * Initialises various event handlers to allow the navigation menu to work.
 */
const init = () => {
  dropdownOverlay = document.querySelector(".header-dropdown-overlay");
  document.querySelectorAll(".header-dropdown-wrapper").forEach(bindToWrapperEvents);
};

addEventListener("turbolinks:load", init);