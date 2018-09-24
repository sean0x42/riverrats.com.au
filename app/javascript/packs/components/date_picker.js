import flatpickr from "flatpickr"

const FIELD_SELECTOR = "input[type='date']:not([data-processed])";
const FLATPICKR_CONFIG = Object.freeze({
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d"
});

/**
 * Search for new date fields on the page. This would
 * typically occur when a date field is loaded dynamically,
 * such as through a modal.
 */
window.checkForDateFields = () => {
  // Retrieve date inputs that have not yet been processed
  const newFields = document.querySelectorAll(FIELD_SELECTOR);
  newFields.forEach((field) => {
    flatpickr(field, FLATPICKR_CONFIG);
    field.setAttribute("data-processed", "true");
  });
};

// Check for new date fields on page load
addEventListener("turbolinks:load", checkForDateFields);