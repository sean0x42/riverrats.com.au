icons =
  OPEN: '&#xE5C5;',
  CLOSE: '&#xE5C7;'

getValueAsString = (select) ->
  value = select.value

  # Ensure value is not empty
  return value if value == ""

  # Iterate over children
  for option in select.children
    return option.innerText if option.value == value

  return ""


###
Creates a new option for a custom select element.
@param option Option to build from.
###
generateOption = (option) ->
  element = document.createElement "li"
  element.classList.add "select-option"
  element.setAttribute "data-value", option.value
  element.innerText = option.innerText

  # Add selected attribute if selected
  if option.hasAttribute "selected"
    element.setAttribute "data-selected", "true"

  return element


###
Creates a new select button wrapper.
@param select Original select element.
###
generateWrapper = (select) ->

  # Create wrapper
  wrapper = document.createElement "div"
  wrapper.classList.add "select-wrapper"

  # Create select button
  button = document.createElement "div"
  button.classList.add "select-button"
  button.innerHTML = "<span>" + getValueAsString(select) + "</span><i class=\"material-icons\">&#xE5C5;</i>"
  wrapper.appendChild button

  # Create dropdown
  dropdown = document.createElement "ul"
  dropdown.classList.add "select-options"

  # Create options
  for child in select.children
    dropdown.append generateOption(child)

  wrapper.appendChild dropdown

  return wrapper


initSelect = (select) ->
  parent  = select.parentNode
  wrapper = generateWrapper(select)

  # Set wrapper as parent element
  parent.replaceChild wrapper, select
  wrapper.appendChild select


###
Toggles the state of the given wrapper.
###
toggleWrapper = (wrapper) ->
  if wrapper.classList.contains "open"
    wrapper.classList.remove "open"
    wrapper.querySelector(".select-button i.material-icons").innerHTML = icons.OPEN
  else
    wrapper.classList.add "open"
    wrapper.querySelector(".select-button i.material-icons").innerHTML = icons.CLOSE


closeAllSelects = ->
  selects = document.querySelectorAll ".select-wrapper.open"
  selects.forEach (select) -> toggleWrapper(select)


###
A delegated event that handles select button clicks.
###
selectButtonClickHandler = (button) ->
  toggleWrapper button.parentNode


###
A delegated event that handle select option clicks.
###
selectOptionClickHandler = (option) ->

  # Update button
  button = option.parentNode.previousElementSibling
  wrapper = button.parentNode
  button.querySelector("span").innerText = option.innerText
  closeAllSelects()

  # Update select input
  select = wrapper.querySelector "select"
  select.value = option.getAttribute "data-value"

  # Fire event
  select.dispatchEvent new Event("change", { bubbles: true })


###
Handles all document clicks. Define delegated event listeners here.
###
delegatedClickHandler = (event) ->
  target = event.target

  # Find parent
  while true

    if target.classList.contains "select-button"
      selectButtonClickHandler(target)
      return

    if target.classList.contains "select-option"
      selectOptionClickHandler(target)
      return

    # Make sure we don't reach the body
    if matches target, "body"
      closeAllSelects()
      return

    # Try the element above
    target = target.parentNode


ready = ->
  selects = document.querySelectorAll "select"
  selects.forEach initSelect

document.addEventListener "turbolinks:load", ready
document.addEventListener "click", delegatedClickHandler