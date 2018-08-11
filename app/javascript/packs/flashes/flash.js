"use strict";

import { renderFlashMessage } from "./flash_controller";

export class Flash {
  constructor(type, title, body) {
    this.type = type;
    this.title = title;
    this.body = body;
  }

  show() {
    renderFlashMessage(this);
  }
}