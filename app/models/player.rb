class Player < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick callbacks: :async, word_start: [:full_name, :username]

  paginates_per 50

  before_validation :generate_username, on: :create

  has_many :games_players, class_name: 'GamesPlayers', dependent: :nullify
  has_many :games, through: :games_players

  has_many :referees, dependent: :nullify
  has_many :games, through: :referees

  has_many :players_venues, class_name: 'PlayersVenues', dependent: :nullify
  has_many :venues, through: :players_venues

  has_many :players_regions, class_name: 'PlayersRegions', dependent: :nullify
  has_many :regions, through: :players_regions

  has_many :players_seasons, class_name: 'PlayersSeasons', dependent: :nullify
  has_many :seasons, through: :players_seasons

  has_many :achievements

  # Virtual attribute for authenticating by either username
  # or email
  attr_accessor :login
  attr_writer :login

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9-]*\z/,
              message: 'only allows numbers, letters, underscores (_), and hyphens (-)'
            },
            length: { minimum: 2 }

  validates :first_name, :last_name,
            presence: true,
            format: {
              with: /\A[a-zA-Z][a-zA-Z-]*[a-zA-Z]\z/,
              message: 'only allows latin letters, and hyphens (-)'
            },
            length: { maximum: 64 }

  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :notify_promotional, :notify_events,
            presence: true

  def to_param
    username
  end


  ###
  # All data to be indexed by Elasticsearch/Searchkick
  # @return [Hash] Data to be indexed.
  def search_data
    { full_name: self.full_name, username: "@#{self.username}" }
  end


  def full_name
    "#{first_name} #{last_name}"
  end

  ###
  # Allows the user of either the username of email to login.
  def login
    @login || self.username || self.email
  end


  ###
  # Override a devise function to allow logging in with
  # either email or username.
  def self.find_for_database_authentication (warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


  def award (achievement)
    base.achievements << achievement.new
  end

  def awarded? (achievement)
    achievements.exists?(type: achievement.sti_name)
  end

  def generate_username
    self.username = UsernameGenerator.generate(first_name, last_name)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

end
