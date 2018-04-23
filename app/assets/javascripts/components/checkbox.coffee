iconEntities =
  CHECKED: "&#xE834;"
  UNCHECKED: "&#xE835;"

updateCheckbox = (checkbox) ->
  input = checkbox.querySelector "input[type='checkbox']"
  icon  = checkbox.querySelector "i.material-icons"
  if input.checked
    checkbox.classList.add "active"
    icon.innerHTML = iconEntities.CHECKED
  else
    checkbox.classList.remove "active"
    icon.innerHTML = iconEntities.UNCHECKED


delegatedChangeHandler = (event) ->
  target = event.target

  # Find parent
  while not target.classList.contains("checkbox")
    return if matches target, "body"
    target = target.parentNode

  updateCheckbox target
  undefined


ready = ->
  checkboxes = document.querySelectorAll ".checkbox"
  checkboxes.forEach updateCheckbox


document.addEventListener "turbolinks:load", ready
document.removeEventListener "change", delegatedChangeHandler
document.addEventListener "change", delegatedChangeHandler
