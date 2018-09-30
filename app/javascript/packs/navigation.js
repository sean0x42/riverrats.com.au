let menuOverlay;
let activeMenu = null;

/**
 * Shows the given dropdown menu.
 * @param wrapper Dropdown wrapper to enable.
 */
const enableMenu = (wrapper) => {
  // Disable current menu
  if (activeMenu != null) {
    disableMenu();
  }

  // Enable
  menuOverlay.setAttribute("active", "");
  wrapper.setAttribute("active", "");
  activeMenu = wrapper;
};

/**
 * Disables currently active menus.
 */
const disableMenu = () => {
  // Ensure a menu is actually enabled
  if (activeMenu === null) {
    return;
  }

  activeMenu.removeAttribute("active");
  menuOverlay.removeAttribute("active");
  activeMenu = null;
};

// /**
//  * An event handler that is fired whenever the mouse enters a dropdown trigger.
//  * @param event Mouse enter event.
//  */
// const onTriggerMouseEnter = (event) => {
//   const { target } = event;
//   enableMenu(target.parentNode);
// };
//
// /**
//  * An event handler that is fired whenever the mouse leaves a menu.
//  */
// const onMenuMouseLeave = () => {
//   disableMenu();
// };

/**
 * An event which is fired whenever the document is clicked.
 * @param event Click event
 */
const onDocumentClick = (event) => {
  const { target } = event;
  if (target.closest(".header-menu-trigger") !== null) {
    return;
  }

  disableMenu();
};

/**
 * Binds to various events on a dropdown wrapper.
 * @param wrapper Wrapper to bind to.
 */
const bindToWrapperEvents = (wrapper) => {
  // Retrieve children
  const trigger = wrapper.children[0];
  const menu = wrapper.children[1];

  // Bind to events
  // trigger.addEventListener("mouseenter", onTriggerMouseEnter);
  // menu.addEventListener("mouseleave", onMenuMouseLeave);
  trigger.addEventListener("click", (event) => {
    const wrapper = event.target.closest(".header-menu-wrapper");
    if (wrapper.hasAttribute("active")) {
      disableMenu();
    } else {
      enableMenu(wrapper);
    }
  });

  document.removeEventListener("click", onDocumentClick);
  document.addEventListener("click", onDocumentClick);
};

/**
 * Initialises various event handlers to allow the navigation menu to work.
 */
const init = () => {
  menuOverlay = document.querySelector(".header-menu-overlay");
  document.querySelectorAll(".header-menu-wrapper").forEach(bindToWrapperEvents);

  const adminNavTrigger = document.querySelector(".mobile-admin-navigation-trigger");
  if (adminNavTrigger !== null) {
    adminNavTrigger.addEventListener("click", () => {
      const nav = document.querySelector("nav.admin-navigation");
      nav.setAttribute("active", "");
    });
  }
};

addEventListener("turbolinks:load", init);