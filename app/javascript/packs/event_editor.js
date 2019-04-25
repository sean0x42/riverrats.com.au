/** @format */

const PERIODS = Object.freeze({
  daily: "day",
  weekly: "week",
  monthly: "month",
  yearly: "year",
});

const UPDATE_SELECTOR =
  ".js-event-type-toggle, .js-period-field select, .js-interval-field input";

/**
 * Determines whether to display or hide certain form elements.
 */
const updateInterface = () => {
  // Init
  const intervalLabel = document.querySelector(".js-interval-label");
  const typeToggle = document.querySelector(".js-event-type-toggle");
  const periodField = document.querySelector(".js-period-field");
  const intervalField = document.querySelector(".js-interval-field");
  const weekdaysField = document.querySelector(".js-weekdays");

  // Ensure fields are defined. Note: toggle won't be defined when editing an event
  if (typeToggle === null) {
    return;
  }

  // Check if the user is creating a repeating event
  if (!typeToggle.checked) {
    periodField.style.display = "none";
    intervalField.style.display = "none";
    weekdaysField.style.display = "none";
    return;
  }

  const interval = parseInt(intervalField.querySelector("input").value);
  const period = periodField.querySelector("select").value;
  periodField.style.display = "block";
  intervalField.style.display = "block";

  // Update interval label
  intervalLabel.innerText = PERIODS[period];
  if (interval !== 1) {
    intervalLabel.innerText += "s";
  }

  // Update weekday checkboxes
  if (period === "weekly") {
    weekdaysField.style.display = "block";
  } else {
    weekdaysField.style.display = "none";
  }
};

/**
 * Initialises the event editor by binding to various DOM events.
 */
window.initEventEditor = () => {
  // init
  const updateFields = document.querySelectorAll(UPDATE_SELECTOR);
  updateFields.forEach(field => {
    field.addEventListener("change", updateInterface);
  });

  // Update
  updateInterface();
};
