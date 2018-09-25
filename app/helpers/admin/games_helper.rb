# frozen_string_literal: true

# A helper for admin games
module Admin::GamesHelper
  def player_to_search_result(player)
    {
      'id': player.id,
      'name': player.full_name,
      'username': "@#{player.username}",
      'isAdmin': player.admin?,
      'isDeveloper': player.developer?
    }.to_json
  end
end
