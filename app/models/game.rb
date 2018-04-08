class Game < ApplicationRecord

  belongs_to :venue
  belongs_to :season

  default_scope { order(id: :desc) }

  paginates_per 50

  has_many :games_players, class_name: 'GamesPlayers', dependent: :nullify, inverse_of: :game
  has_many :players, through: :games_players

  has_many :referees, dependent: :nullify, inverse_of: :game
  has_many :players, through: :referees

  accepts_nested_attributes_for :games_players,
                                reject_if: :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :referees,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :venue, :season, :played_on,
            presence: true

  validate :validate_referees, :validate_players

  def validate_players
    if games_players.size < 2
      errors.add(:games_players, 'not enough')
    end
  end

  def validate_referees
    if referees.size < 1
      errors.add(:referees, 'not enough')
    end
  end

  def name
    "Game ##{self.id}"
  end

end
