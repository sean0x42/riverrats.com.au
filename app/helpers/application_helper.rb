# frozen_string_literal: true

# A helper which is available application wide.
module ApplicationHelper
  NUMBER_FORMAT_OPTIONS = {
    format: '%n%u',
    precision: 3,
    units: { thousand: 'k', million: 'm', billion: 'b' }
  }.freeze

  def field_errors(model, field)
    render 'application/field_errors', model: model, field: field
  end

  # Returns the players position, correctly formatted.
  def position(player, index, page = 1, per = 25)
    page ||= 1
    if player.has_attribute?(:rank)
      player.rank.nil? ? 'n/a' : (player.rank + 1).ordinalize
    else
      ((page - 1) * per + index + 1).ordinalize
    end
  end

  def number_format(value)
    number_to_human(value, NUMBER_FORMAT_OPTIONS)
  end

  def flair(player)
    return if player.group == 'player'

    render 'application/player_flair', player: player
  end
end
