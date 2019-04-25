/** @format */

const ELEMENT_SELECTOR = `select:not([data-better-select="false"]):not([data-processed])`;

/**
 * Attempts to retrieve the value of a select element as a
 * string.
 * @param select Select element to retrieve value of.
 * @return {*} A string containing the value.
 */
const getValueAsString = select => {
  // Init
  const value = select.value;
  const defaultValue = "None";
  if (value === "") return defaultValue;

  // Iterate over children
  const children = select.children;
  for (let i = 0; i < children.length; i++) {
    if (children[i].value === value) return children[i].textContent;
  }

  return defaultValue;
};

/**
 * An event handler, that should be fired whenever the
 * trigger for a better select element is clicked.
 * @param event Click event.
 */
const onSelectTriggerClick = event => {
  // Buttons inside a form will submit their parent form when clicked => prevent default
  event.preventDefault();
  const wrapper = event.target.parentNode;

  // Disable all selects
  document
    .querySelectorAll(".better-select-wrapper[active]")
    .forEach(select => {
      if (select !== wrapper) {
        select.removeAttribute("active");
      }
    });

  // Toggle wrapper
  if (wrapper.hasAttribute("active")) {
    wrapper.removeAttribute("active");
  } else {
    wrapper.setAttribute("active", "");
  }
};

/**
 * Builds a custom select wrapper around an existing select element.
 * @param select Existing select element.
 */
const buildSelectWrapper = select => {
  const value = getValueAsString(select);

  // Construct wrapper
  const wrapper = document.createElement("div");
  wrapper.classList.add("better-select-wrapper");

  // Construct trigger
  const trigger = document.createElement("button");
  const content = document.createElement("span");
  trigger.addEventListener("click", onSelectTriggerClick);
  trigger.classList.add("better-select-trigger");
  content.textContent = value;
  trigger.appendChild(content);
  trigger.innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve"><path d="M8.71,11.71l2.59,2.59c0.39,0.39,1.02,0.39,1.41,0l2.59-2.59c0.63-0.63,0.18-1.71-0.71-1.71H9.41C8.52,10,8.08,11.08,8.71,11.71z"></path></svg>`;
  wrapper.appendChild(trigger);

  // Construct dropdown
  const dropdown = document.createElement("ul");
  dropdown.classList.add("better-select-dropdown");
  wrapper.appendChild(dropdown);

  // Add options to dropdown
  select.querySelectorAll("option").forEach(option => {
    const child = document.createElement("li");
    child.classList.add("better-select-option");
    child.setAttribute("data-value", option.value);
    child.textContent = option.textContent;
    child.addEventListener("click", onSelectOptionClick);
    dropdown.appendChild(child);
  });

  select.parentNode.insertBefore(wrapper, select);
};

/**
 * An event handler, that should be fired whenever an
 * option for a better select element is clicked.
 * @param event Click event.
 */
const onSelectOptionClick = event => {
  const { target } = event;
  const value = target.getAttribute("data-value");
  const label = target.textContent;

  // Update wrapper
  const wrapper = event.target.parentNode.parentNode;
  wrapper.removeAttribute("active");

  // Update trigger
  const triggerContent = wrapper.querySelector(".better-select-trigger > span");
  triggerContent.textContent = label;

  // Update select element
  wrapper.nextElementSibling.value = value;

  // Fire change event
  const changeEvent = new Event("change");
  wrapper.nextElementSibling.dispatchEvent(changeEvent);
};

/**
 * Search for new select elements on the page. This would
 * typically occur when a select element is loaded
 * dynamically, such as through a modal.
 */
window.checkForSelects = () => {
  // Retrieve select elements that have not yet been processed
  const selects = document.querySelectorAll(ELEMENT_SELECTOR);
  selects.forEach(select => {
    buildSelectWrapper(select);
    select.setAttribute("data-processed", "true");
  });
};

addEventListener("turbolinks:load", checkForSelects);
