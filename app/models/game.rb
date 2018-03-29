class Game < ApplicationRecord

  has_many :games_players,
           class_name: 'GamesPlayers',
           dependent: :nullify
  has_many :players, through: :games_players

  has_and_belongs_to_many :players, join_table: :referees

  belongs_to :event

  validates :event,
            presence: true

end
