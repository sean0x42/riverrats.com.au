import flatpickr from "flatpickr";

const DATE_SELECTOR = "input[type='date']:not([data-processed]), .datepickr:not([data-processed])";
const DATE_CONFIG = Object.freeze({
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d"
});

const DATE_TIME_CONFIG = Object.freeze({
  altInput: true,
  enableTime: true,
  altFormat: "h:iK, j/m/y",
  dateFormat: "Y-m-d H:i"
});

/**
 * Search for new date fields on the page. This would
 * typically occur when a date field is loaded dynamically,
 * such as through a modal.
 */
window.checkForDateFields = () => {
  // Retrieve date inputs that have not yet been processed
  const newFields = document.querySelectorAll(DATE_SELECTOR);
  newFields.forEach((field) => {
    // Get type of field
    let type = "date";
    if (field.hasAttribute("data-conf-type")) {
      type = field.getAttribute("data-conf-type");
    }

    flatpickr(field, type === "date" ? DATE_CONFIG : DATE_TIME_CONFIG);
    field.setAttribute("data-processed", "true");
  });
};

// Check for new date fields on page load
addEventListener("turbolinks:load", checkForDateFields);