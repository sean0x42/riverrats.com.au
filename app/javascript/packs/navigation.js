/**
 * Initialises various event handlers to allow the navigation menu to work.
 */
const initNavigation = () => {
  document.querySelectorAll(".header-dropdown-trigger").forEach(trigger => {
    trigger.addEventListener("mouseenter", hoverHandler);
    // trigger.parentNode.addEventListener("mouseleave", leaveHandler);
  });
};

/**
 * An event handler that is fired whenever the user hovers over a navigation drop down trigger.
 * @param event Mouse enter event.
 */
const hoverHandler = event => {
  const { target } = event;
  target.parentNode.setAttribute("active", "");
};

/**
 * An event handler that is fired whenever the user's mouse leaves the dropdown.
 * @param event Mouse leave event.
 */
const leaveHandler = event => {
  const { target } = event;
  target.removeAttribute("active");
};

addEventListener("turbolinks:load", initNavigation);