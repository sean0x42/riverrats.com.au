# frozen_string_literal: true

# Represents a single game recorded by tournament directors
class Game < ApplicationRecord
  default_scope { order(id: :desc) }

  searchkick callbacks: :async

  after_save :update_stats, :update_ranks
  after_destroy :update_stats, :update_ranks

  belongs_to :venue
  belongs_to :season

  has_many :players, through: :games_players
  has_many :players, through: :referees

  with_options dependent: :delete_all, inverse_of: :game do
    has_many :games_players, class_name: 'GamesPlayer'
    has_many :referees
    has_many :comments
  end

  with_options reject_if: :all_blank, allow_destroy: true do
    accepts_nested_attributes_for :games_players
    accepts_nested_attributes_for :referees
  end

  validates :venue, :season, :played_on, presence: true
  validate :player_count, :referee_count, :no_duplicate_players,
           :no_duplicate_referees, :within_season

  def name
    "##{id.to_s.rjust(2, '0')}"
  end

  def search_data
    { name: name }
  end

  def paginated_players(page)
    GamesPlayer.includes(:player).where(game_id: id).page(page).per(25)
  end

  def self.recent(days = 30)
    Game.where('created_at > ?', Time.zone.today - days.days)
  end

  def game_played_by
    Player.joins(:games_players).where(games_players: { game_id: id })
  end

  def award_tickets(tickets)
    GameTicketsWorker.perform_async(id, tickets) unless tickets.nil?
  end

  private

  def player_count
    return unless games_players.size < 2

    errors.add :games_players, I18n.t('errors.game.too_few_players')
  end

  def referee_count
    return unless referees.empty?

    errors.add :referees, I18n.t('errors.game.too_few_referees')
  end

  def no_duplicate_players
    player_ids = games_players.map(&:player_id)
    return if player_ids.uniq.length == player_ids.length

    errors.add :games_players, I18n.t('errors.game.duplicate_players')
  end

  def no_duplicate_referees
    player_ids = referees.map(&:player_id)
    return if player_ids.uniq.length == player_ids.length

    errors.add :referees, I18n.t('errors.game.duplicate_referees')
  end

  def within_season
    return if played_on >= season.start_at && played_on <= season.end_at

    errors.add :played_on, I18n.t('errors.game.played_outside_season')
  end

  def update_stats
    venue = self.venue
    region = venue.region.id
    season = self.season.id
    game_played_by.pluck(:id).each do |player|
      CalculateVenueStatsWorker.perform_async(venue.id, player)
      CalculateRegionStatsWorker.perform_async(region, player)
      CalculateSeasonStatsWorker.perform_async(season, player)
    end
  end

  def update_ranks
    CalculateRanksWorker.perform_in(2.minutes)
    CalculateSeasonRanksWorker.perform_in(3.minutes, season.id)
  end
end
