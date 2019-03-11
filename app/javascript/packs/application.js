/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Polyfills
import "promise-polyfill/src/polyfill";
import "whatwg-fetch";
import "./polyfill/closest";
import "./polyfill/includes";

// Components
import "./components/flashes/flash_controller";
import "./components/modals/modal_controller";
import "./components/date_picker";
import "./components/better_select";
import "./components/player_input.js";

// Application
import "./navigation";
import "./game_editor";
import "./event_editor";
import "./ujs_event_handler";
