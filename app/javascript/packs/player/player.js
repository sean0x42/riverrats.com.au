"use strict";

export class Player {
  constructor(id, name, username, isAdmin, isDeveloper) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.isAdmin = isAdmin;
    this.isDeveloper = isDeveloper;
  }

  asElement() {
    // Init
    const player = document.createElement("div");
    const nameSpan = document.createElement("span");
    const usernameSpan = document.createElement("span");

    // Classes
    player.classList.add("inline-player");
    nameSpan.classList.add("highlight");

    // Content
    nameSpan.innerText = this.name;
    usernameSpan.innerText = this.username;
    player.appendChild(nameSpan);
    player.appendChild(usernameSpan);

    // Flair
    if (this.isDeveloper || this.isAdmin) {
      const flair = document.createElement("span");
      flair.classList.add("flair");
      flair.innerText = this.isDeveloper ? "developer" : "admin";
      player.appendChild(flair);
    }

    return player;
  }
}
