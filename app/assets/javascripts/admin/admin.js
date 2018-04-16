//= require jquery-3.3.1.min
//= require cocoon
//= require Sortable.min
//= require pikaday
//= require typeahead.bundle.min
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () {
    new Pikaday({ field: $("#game_played_on")[0] })
});