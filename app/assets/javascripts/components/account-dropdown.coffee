closeDropdown = ->
  dropdown = document.querySelector ".account-dropdown"
  dropdown.classList.remove "active"

toggleDropdown = ->
  dropdown = document.querySelector ".account-dropdown"
  if dropdown.classList.contains "active"
    dropdown.classList.remove "active"
  else
    dropdown.classList.add "active"


delegatedClickHandler = (event) ->
  target = event.target

  # Find parent
  while true

    if target.classList.contains "account-wrapper"
      toggleDropdown()
      return

    # Make sure we don't reach the body
    if matches target, "body"
      closeDropdown()
      return

    # Try the element above
    target = target.parentNode


document.addEventListener "click", delegatedClickHandler