function ready(func) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
    func();
  } else {
    document.addEventListener("DOMContentLoaded", func);
  }
}

ready(function() {
  var metaTag = document.querySelector("meta[name='current-user']");

  // Ensure that the player is logged in
  if (metaTag !== null) {
    App.notification = App.cable.subscriptions.create("NotificationChannel", {
      connected: function() {
        // Called when the subscription is ready for use on the server
        console.debug("Connected. Listening for notifications.");
      },

      disconnected: function() {
        // Called when the subscription has been terminated by the server
        console.debug("Disconnected. No longer listening for notifications.");
      },

      received: function(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("Data incoming...");
        console.log(data);
      }
    });
  }
});

