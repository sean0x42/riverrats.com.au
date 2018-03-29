class Player < ApplicationRecord

  # noinspection SpellCheckingInspection
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :generate_username, on: :create

  has_many :games_players,
           class_name: 'GamesPlayers',
           dependent: :nullify
  has_many :games, through: :games_players

  has_and_belongs_to_many :games, join_table: :referees

  has_many :players_venues,
           class_name: 'PlayersVenues',
           dependent: :nullify
  has_many :venues, through: :players_venues

  has_many :players_regions,
           class_name: 'PlayersRegions',
           dependent: :nullify
  has_many :regions, through: :players_regions

  has_many :players_seasons,
           class_name: 'PlayersSeasons',
           dependent: :nullify
  has_many :seasons, through: :players_seasons

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  attr_writer :login

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9-]*\z/,
              message: 'only allows numbers, letters, underscores (_), and hyphens (-)'
            },
            length: { is: 2 }

  validates :first_name, :last_name,
            presence: true,
            format: {
              with: /\A[a-zA-Z-]*\z/,
              message: 'only allows latin letters, and hyphens (-)'
            },
            length: { maximum: 64 }

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :notify_promotional, :notify_events,
            presence: true

  def to_param
    username
  end

  # @return [String] Player's full name.
  def full_name
    "#{first_name} #{last_name}"
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication (warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
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
