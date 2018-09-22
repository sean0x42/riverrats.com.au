# frozen_string_literal: true

# A helper which is available application wide.
module ApplicationHelper
  # Renders a search field
  def render_search(url, placeholder)
    render partial: 'application/search',
           locals: {
             url: url,
             placeholder: placeholder
           }
  end

  # Renders field errors
  def field_errors(model, field)
    render 'application/field_errors', model: model, field: field
  end

  # Returns the players position, correctly formatted.
  def position(player, index, page = 1, per = 25)
    if player.has_attribute?(:rank)
      player.rank.nil? ? 'n/a' : (player.rank + 1).ordinalize
    else
      (page - 1 * per + index).ordinalize
    end
  end
end
