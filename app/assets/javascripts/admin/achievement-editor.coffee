typeaheadSelectHandler = (event, result) ->
  $(event.target)
    .closest ".field"
    .children "#achievement_player_id"
    .val result.id

$(document).on "turbolinks:load", ->
  $(".typeahead-achievement")
    .typeahead TYPEAHEAD_OPTIONS, TYPEAHEAD_DATASET
    .bind "typeahead:select", typeaheadSelectHandler