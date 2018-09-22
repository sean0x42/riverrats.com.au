# frozen_string_literal: true

# Represents a single game recorded by tournament directors
class Game < ApplicationRecord
  belongs_to :venue
  belongs_to :season

  default_scope { order(id: :desc) }

  searchkick callbacks: :async

  has_many :games_players,
           class_name: 'GamesPlayer',
           dependent: :delete_all,
           inverse_of: :game
  has_many :players, through: :games_players
  has_many :referees, dependent: :delete_all, inverse_of: :game
  has_many :players, through: :referees

  accepts_nested_attributes_for :games_players,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :referees,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :venue, :season, :played_on, presence: true
  validate :player_count,
           :referee_count,
           :no_duplicate_players,
           :no_duplicate_referees

  def name
    "##{id.to_s.rjust(2, '0')}"
  end

  def search_data
    { name: name }
  end

  # def update_ranks
  #   region = venue
  #   UpdateGlobalRanksJob.perform_later
  #   UpdateSeasonRanksJob.perform_later self.season
  # end

  def paginated_players(page)
    GamesPlayer.includes(:player).where(game_id: self.id).page(page).per(25)
  end

  def player_count
    return unless players.size < 2

    errors.add :games_players, I18n.t('errors.game.too_few_players')
  end

  def referee_count
    return unless referees.size.empty?

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

  def self.recent(days = 30)
    Game.where('created_at > ?', Time.zone.today - days.days)
  end
end
