
POPUP_DELAY = 300
hoveredElement = null
playerCache = {}


###
An event handler that is fired whenever a link with a profile preview is hovered
over.
###
previewHover = (event) ->

  # Init
  wrapper     = document.querySelector ".profile-preview-wrapper"
  preview     = wrapper.querySelector ".profile-preview"
  target      = event.target
  targetRect  = target.getBoundingClientRect()
  previewRect = preview.getBoundingClientRect()

  # Calculate left and right
  wrapper.style.display = "block"
  left = targetRect.left - 10
  top  = targetRect.top + window.scrollY - 88 - 10
  wrapper.style.left = left + "px";
  wrapper.style.top = top + "px";
  console.log event


###
Creates a player preview window, but hides it at the bottom of the doc
###
createPreview = ->

  # Remove any existing wrappers
  wrappers = document.querySelectorAll ".profile-preview-wrapper"
  wrappers.forEach (wrapper) -> wrapper.parentNode.removeChild(wrapper)

  # Create new wrapper
  wrapper = document.createElement "div"
  wrapper.classList.add "profile-preview-wrapper"
  wrapper.innerHTML = "<div class='profile-preview'><div class='player-info'><p class='player-name'>Sean Bailey</p><p class='player-username'>@seanbailey</p></div>150</div>"
  wrapper.style.display = "none"
  document.body.appendChild wrapper

  # Add mouse leave listener
  wrapper.addEventListener "mouseleave", disablePreview


###
Disables the player preview object.
###
disablePreview = ->
  wrapper = document.querySelector ".profile-preview-wrapper"
  wrapper.style.display = "none"


###
A function that is called once the document is ready
###
ready = ->
  createPreview()
  links = document.querySelectorAll "a[data-show-profile-preview]"
  links.forEach (link) ->
    link.addEventListener "mouseover", previewHover

#document.addEventListener "turbolinks:load", ready