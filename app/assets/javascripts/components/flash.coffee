hideFlash = (flash) ->
  flash.style.display = "none"

delegatedClickHandler = (event) ->
  target = event.target

  # Find parent
  while true

    if target.classList.contains "flash"
      hideFlash(target)
      return

    # Make sure we don't reach the body
    if matches target, "body"
      return

    # Try the element above
    target = target.parentNode


document.addEventListener "click", delegatedClickHandler