/** @format */

/**
 * Determines whether an element matches a given selector accross IE9+ browsers
 *
 * @example
 * // element = <div class="test">Hello, world!</div>
 * matches(element, "div.test");
 * // true
 *
 * @param {Element} el Element to test.
 * @param {string} selector Selector to match against.
 * @return {boolean} Whether the selector matches the element.
 */
export function matches(el, selector) {
  return (
    el.matches ||
    el.matchesSelector ||
    el.msMatchesSelector ||
    el.mozMatchesSelector ||
    el.webkitMatchesSelector ||
    el.oMatchesSelector
  ).call(el, selector);
}

/**
 * Finds the closest matching parent element, or null if no matching ancestor
 * can be found.
 *
 * @param {Element} el Element to begin the search from.
 * @param {string} selector Selector to match against.
 * @return {?Element} First matching ancestor element or null.
 */
export function closest(el, selector) {
  while (el) {
    if (matches(el, selector)) {
      return el;
    }

    el = el.parentElement;
  }

  return null;
}
