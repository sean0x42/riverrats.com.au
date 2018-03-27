class Player < ApplicationRecord

  # noinspection SpellCheckingInspection
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :game_players
  has_many :games, through: :game_players

  has_and_belongs_to_many :games

  has_many :venue_players
  has_many :venues, through: :venue_players

  has_many :region_players
  has_many :regions, through: :region_players

  has_many :season_players
  has_many :seasons, through: :season_players

  attr_accessor :login
  attr_writer :login

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9_\.-]*\z/,
              message: 'only allows numbers, letters, underscores (_), and hyphens (-)'
            },
            length: { minimum: 6 }

  validates :first_name, :last_name,
            presence: true,
            length: { maximum: 64 }

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
