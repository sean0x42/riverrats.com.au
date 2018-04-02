class Game < ApplicationRecord

  belongs_to :venue
  belongs_to :season

  has_many :games_players,
           class_name: 'GamesPlayers',
           dependent: :nullify,
           inverse_of: :game
  has_many :players, through: :games_players

  has_many :referees,
           dependent: :nullify,
           inverse_of: :game
  has_many :players, through: :referees

  accepts_nested_attributes_for :games_players,
                                reject_if: :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :referees,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :venue, :season,
            presence: true

  def name
    "Game ##{self.id}"
  end



end
