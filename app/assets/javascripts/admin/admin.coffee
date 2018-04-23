#= require jquery-3.3.1.min
#= require cocoon
#= require Sortable.min
#= require flatpickr.min
#= require typeahead.bundle.min
#= require_tree .

$(document).on 'turbolinks:load', ->
  flatpickr ".date-input:not([type='hidden'])", { altInput: true }
  flatpickr ".date-time-input:not([type='hidden'])", { enableTime: true, altInput: true }