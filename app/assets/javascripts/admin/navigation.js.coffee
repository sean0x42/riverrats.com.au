
###
Handles click events on the more navigation button.
###
moreClickHandler = (button) ->
  navigation = button.parentNode.parentNode
  if navigation.classList.contains "open"
    navigation.classList.remove "open"
    document.body.classList.remove "no-scroll"
  else
    navigation.classList.add "open"
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
    if matches target, ".admin-navigation .more"
      moreClickHandler(target)
      return

    break if matches target, "body"

    # Move to next node up the DOM
    target = target.parentNode


document.addEventListener "click", delegatedClickHandler