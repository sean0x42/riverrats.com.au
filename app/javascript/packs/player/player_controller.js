/** @format */

import { Player } from "./player";

/**
 * Creates a new player object, based on the results of a search.
 * @param result Search result.
 */
export function createPlayerFromSearch(result) {
  return new Player(
    result.id,
    result.full_name,
    result.username,
    result.is_admin,
    result.is_developer
  );
}
