class Player < ApplicationRecord

  # noinspection SpellCheckingInspection
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :generate_username, on: :create

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
              with: /\A[a-zA-Z0-9-]*\z/,
              message: 'only allows numbers, letters, underscores (_), and hyphens (-)'
            },
            length: { minimum: 6 }

  validates :first_name, :last_name,
            presence: true,
            format: {
              with: /\A[a-zA-Z-]*\z/,
              message: 'only allows latin letters, and hyphens (-)'
            },
            length: { maximum: 64 }

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :notify_promotional, :notify_events, :is_admin,
            presence: true

  def to_param
    username
  end

  # @return [String] Player's full name.
  def full_name
    "#{first_name} #{last_name}"
  end

  private

    ###
    # Generates a unique username comprised of the player's first name,
    # last name, and a unique number.
    # ...
    def generate_username

      # Ensure username has not already been set
      if self.username.nil?

        count = 0

        # Keep looping until we reach a unique username
        begin
          username = "#{first_name}#{last_name}#{count if count != 0}".downcase
          count += 1
        end while Player.exists?(username: username)

        self.username = username

      end
    end

end
