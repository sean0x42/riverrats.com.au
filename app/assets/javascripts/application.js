// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require local-time
//= require_tree ./components/
//= require_tree ./util/

function print(selector) {

    var printWindow = window.open();
    var css = document.querySelectorAll("link");
    var title = document.title;

    // Add document head
    printWindow.document.write("<!DOCTYPE html><html><head><title>" + title + "</title>");

    // Add CSS
    printWindow.document.write(
        "<style>" +
            ".button," +
            ".button-secondary," +
            ".button-tertiary," +
            ".material-icons," +
            ".pagination," +
            ".no-print," +
            ".achievement img," +
            "svg {display:none;}" +
            "body{font-family:'-apple-system','system-ui','BlinkMacSystemFont','Segoe UI','Roboto','Helvetica Neue','Arial','sans-serif','Apple Color Emoji','Segoe UI Emoji','Segoe UI Symbol'}" +
            ".stat .numeric,.stat .label{display:inline;}" +
        "</style>"
    );

    // Close head
    printWindow.document.write("</head><body>");
    printWindow.document.write(document.querySelector(selector).innerHTML);
    printWindow.document.write("</body></html>");
    printWindow.document.close();

    printWindow.print();
    printWindow.close();

}