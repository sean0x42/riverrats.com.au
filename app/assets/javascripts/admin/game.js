$(document).ready(function () {
    $(document).on("typeahead:select", function (event, result) {
        $("#players").append("<li data-username='" + result["username"] + "'>" + result["name"] + "</li>");
        window.setTimeout(function() {
            $("#query").val("");
        }, 1);
    });
});