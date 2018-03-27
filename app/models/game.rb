class Game < ApplicationRecord

  has_many :game_players
  has_many :players, through: :game_players

  has_and_belongs_to_many :players

  belongs_to :event

  validates :event,
            presence: true

end
