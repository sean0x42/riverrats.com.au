
###
Handles click events on the account navigation button.
###
accountClickHandler = (button) ->
  navigation = document.querySelector ".js-more-overflow"
  if navigation.classList.contains "active"
    navigation.classList.remove "active"
    document.body.classList.remove "no-scroll"
  else
    navigation.classList.add "active"
    document.body.classList.add "no-scroll"


###
An event handler for all document clicks. Register your delegated click
listeners here.
###
delegatedClickHandler = (event) ->

  # Get element that was clicked
  target = event.target

  # Loop until the top of the DOM is reached
  while true

    # Check for more button click
    if matches target, ".js-more"
      accountClickHandler(target)
      return

    break if matches target, "body"

    # Move to next node up the DOM
    target = target.parentNode


document.addEventListener "click", delegatedClickHandler