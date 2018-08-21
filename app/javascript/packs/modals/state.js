/**
 * @enum which tracks the current state of the modal controller.
 */
export const State = Object.freeze({
  DISPLAYING_MODAL: Symbol("displaying"),
  AWAITING_MODAL: Symbol("awaiting"),
  NONE: Symbol('none')
});