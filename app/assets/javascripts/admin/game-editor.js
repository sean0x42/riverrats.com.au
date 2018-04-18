
/**
 * Keeps track of the currently selected result.
 * @type {Object}
 */
var currentResult = null;


/**
 * Data source for players.
 * @const
 */
var playerSource = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
        url: '/players/auto-complete?query=%QUERY',
        wildcard: '%QUERY'
    }
});


/**
 * A hash of options for Typeahead.js
 * @const
 */
var TYPEAHEAD_OPTIONS = {
    highlight: true
};


/**
 * A hash outlining how Typeahead should handle it's dataset (bloodhound)
 * @const
 */
var TYPEAHEAD_DATASET = {
    source: playerSource,
    limit: 10,
    display: "username",
    templates: {
        empty: "<div class='empty'>No matches.</div>",
        suggestion: function (data) {
            return "<div>" + data.name + " " + data.username + "</div>";
        }
    }
};


/**
 * A hash of options for Sortable.js
 * @const
 */
var SORTABLE_OPTIONS = {
    onSort: update
};


/**
 * A function which handles the Typeahead.js select event.
 * @param event Event object.
 * @param result Selected element.
 */
function onTypeaheadSelect (event, result) {
    currentResult = result;
    // Simulate a link click
    $(event.target)
        .parent()
        .next("a.add_fields")
        .click();
}


/**
 * A function which handles the Cocoon before insert event.
 * @param event Event object.
 * @param insertedElement Element being inserted into the page.
 */
function onCocoonInsert (event, insertedElement) {

    // Ensure a current result exists
    if (currentResult === null) {
        event.preventDefault();
    }

    // Update labels
    console.log(currentResult);
    insertedElement.children(".player-id-input").val(currentResult.id);
    insertedElement.children(".player-name").html(currentResult.name);
    insertedElement.children(".player-username").html(currentResult.username);

    // Clear typeahead
    $(".typeahead").typeahead("val", "");
    currentResult = null;

}


/**
 * A function which handles the Cocoon before remove event.
 * @param event Event object.
 * @param removedElement Element being removed.
 */
function onCocoonRemove (event, removedElement) {
    removedElement.addClass("removed");
    update();
}


/**
 * A function which handles form submit events.
 * @param event Event object.
 */
function onFormSubmit (event) {

    // Update positions
    $(".player-list.sortable")
        .find(".player-position-input")
        .each(function (index, element) {
            $(element).val(index);
        });

}


/**
 * Updates the entire player list.
 */
function update () {

    var $list = $(".player-list");

    // Get list of players
    var $players = $list.find(".player:not(.removed)");
    var $empty = $list.children(".player.empty");

    // Handle empty list
    if ($players.length === 0 && $empty.length === 0) {
        var $wrapper = $("<div>", { class: 'player empty' });
        $("<p>", { text: "You haven't added any players yet. Add one below." }).appendTo($wrapper);
        $wrapper.appendTo($list);
    } else if ($empty.length !== 0) {
        $empty.remove();
    }

    updatePositions();

}


/**
 * Updates the positions of each player.
 */
function updatePositions () {

    var $list = $(".player-list.sortable");

    // Get list of players
    var $players = $list.find(".player:not(.removed)");

    $players.each(function (index, element) {

        // Get relevant children
        var $input = $(element).children(".player-position-input");
        var $label = $(element).children(".player-position");

        $input.val(index);
        $label.html((index + 1) + ".");

    });

}


$(document).on('turbolinks:load', function () {

    // Init sortable
    var sortableElem = document.querySelector(".sortable");
    if (sortableElem !== null) {
        Sortable.create(sortableElem, SORTABLE_OPTIONS);
    }

    // Init typeahead
    $(".typeahead")
        .typeahead(TYPEAHEAD_OPTIONS, TYPEAHEAD_DATASET)
        .bind("typeahead:select", onTypeaheadSelect);

    // Register events
    var $form = $("form");
    $form.off("cocoon:before-insert");
    $form.on("cocoon:before-insert", onCocoonInsert);
    $form.off("cocoon:after-insert");
    $form.on("cocoon:after-insert", update);
    $form.off("cocoon:before-remove");
    $form.on("cocoon:before-remove", onCocoonRemove);
    $form.off("submit");
    $form.on("submit", onFormSubmit);

    update();

});