String.prototype.trunc = (n) ->
  # Return if under the max length
  return this if this.length <= n
  return this.substr(0, n - 1) + "&hellip;"

onInputChange = (event) ->
  input = event.target

  # Ensure that event target is a file input
  return if not input.hasAttribute("type") and input.getAttribute("type") == "file"

  file = input.value.split("\\").pop().trunc(25)

  input
    .previousElementSibling
    .querySelector "label > span"
    .innerHTML = if file? then file else "No file chosen"

document.addEventListener "change", onInputChange
