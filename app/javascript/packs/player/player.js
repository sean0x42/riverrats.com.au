/**
 * Represents a single player.
 */
export class Player {
  constructor(id, name, username, isAdmin, isDeveloper) {
    this.uniqueId = (new Date()).getTime();
    this.id = id;
    this.name = name;
    this.username = username;
    this.isAdmin = isAdmin;
    this.isDeveloper = isDeveloper;
    this.fresh = true;
  }

  /**
   * Parses a JSON string to create a player.
   * @param json JSON string.
   * @returns {Player} Created player.
   */
  static fromJSON(json) {
    const parsed = JSON.parse(json);
    const player = new Player(parsed.id.toString(), parsed.name, parsed.username, parsed.isAdmin, parsed.isDeveloper);
    player.fresh = false;
    player.uniqueId = parsed.id;
    return player;
  }

  /**
   * An element representation of this player.
   * @returns {HTMLElement} Element containing information about this player.
   */
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
