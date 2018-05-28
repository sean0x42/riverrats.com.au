require 'set'

class Admin::AttributeCollector


  ###
  # Retrieves a hash of player usernames.
  # @param [Hash] params A hash of all parameters
  # @return [Hash] A hash in the form { player_id: player_full_name }
  def self.from_params (params)

    players = Set.new

    # Add players
    if params[:game].has_key? :games_players_attributes
      attributes = params[:game][:games_players_attributes].values
      players.merge attributes.map { |set| set[:player_id] }
    end

    # Add referees
    if params[:game].has_key? :referees_attributes
      attributes = params[:game][:referees_attributes].values
      players.merge attributes.map { |set| set[:player_id] }
    end

    self.to_name_hash Player.where(id: players.to_a)

  end


  ###
  # Retrieves a hash of player usernames.
  # @param [Integer] game_id Game to retrieve players from.
  # @return [Hash] A hash in the form { player_id => player_full_name }
  def self.from_db (game_id)

    # Get all players and referees
    players = Player.joins(:games_players).where(games_players: { game_id: game_id }).reorder('')
    referees = Player.joins(:referees).where(referees: { game_id: game_id }).reorder('')

    # Join using an SQL union
    join = Player.from("(#{players.to_sql} UNION #{referees.to_sql}) AS players")

    # Map to attributes array
    return to_name_hash join

  end


  def self.empty_attrs
    { names: {}, usernames: {} }.symbolize_keys!
  end


  private

  ###
  # Converts a collection of +players+ into a hash.
  # @param [Collection] players Collection of players.
  # @return [Hash] A hash in the form { player_id => player_username }
  def self.to_name_hash (players)
    attrs = self.empty_attrs
    attrs[:names] = players.map { |player| [player.id, player.full_name] }.to_h
    attrs[:usernames] = players.map { |player| [player.id, "@#{player.username}"] }.to_h
    return attrs
  end

end