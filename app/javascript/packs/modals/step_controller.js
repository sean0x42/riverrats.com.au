/**
 * Manages the process of stepping through a modal window.
 */
export class StepController {

  /**
   * Constructs a new step controller.
   * @param modal Modal window to manage.
   */
  constructor(modal) {
    this.modal = modal;
    this._init();
  }

  /**
   * Initialises the step controller, and adds various event listeners.
   * @private
   */
  _init() {
    const steps = this.modal.querySelectorAll(".step");

    // Create previous and next links
    const len = steps.length;
    for (let i = 0; i < len; i++) {
      // Add a next button unless this is the last step
      if (i !== len - 1) {
        const nextLabel = steps.item(i + 1).getAttribute("data-step-label");
        steps.item(i).appendChild(StepController._createNextLink(nextLabel));
      }

      // Add previous button unless this is the first step
      if (i !== 0) {
        const previousLabel = steps.item(i - 1).getAttribute("data-step-label");
        steps.item(i).appendChild(StepController._createPreviousLink(previousLabel));
      }
    }

    // Display the first step
    steps.item(0).setAttribute("active", "");
  }

  /**
   * Constructs a link to the next step.
   * @param label Label for the link.
   * @return {HTMLElement} Link to next step.
   * @private
   */
  static _createNextLink(label) {
    const link = document.createElement("a");

    // Set element attributes
    link.classList.add("button-secondary", "wide");
    link.href = "javascript:void";
    link.textContent = label;

    // Bind to click event
    link.addEventListener("click", StepController.nextStep);

    return link;
  }

  /**
   * Constructs a link to the previous step.
   * @param label Label for the link.
   * @return {HTMLElement} A link to the previous step.
   * @private
   */
  static _createPreviousLink(label) {
    const link = document.createElement("a");

    // Set element attributes
    link.href = "javascript:void";
    link.textContent = `${label} (Previous)`;
    link.classList.add("previous-step");

    // Bind to click event
    link.addEventListener("click", StepController.previousStep);

    return link;
  }

  /**
   * Progresses the modal forward one step. Should be bound
   * to a click event.
   * @param event Click event.
   */
  static nextStep(event) {
    const { target } = event;
    const step = StepController._getParentStep(target);
    step.removeAttribute("active");
    step.nextElementSibling.setAttribute("active", "");
  }

  /**
   * Progresses the modal back one step. Should be bound to
   * a click event.
   * @param event Click event.
   */
  static previousStep(event) {
    const { target } = event;
    const step = StepController._getParentStep(target);
    step.removeAttribute("active");
    step.previousElementSibling.setAttribute("active", "");
  }

  /**
   * Climbs to DOM tree to find the parent step. Returns null if not found.
   * @param element Element to climb from.
   * @return {HTMLElement} Parent step element.
   * @private
   */
  static _getParentStep(element) {
    let step = element;

    // Get parent step by climbing the DOM tree
    while (!step.classList.contains("step")) {
      step = step.parentNode;

      // Ensure we don't reach the root
      if (step === document.body) {
        console.error("Step was not wrapped in a modal form.");
        return null;
      }
    }

    return step;
  }

}