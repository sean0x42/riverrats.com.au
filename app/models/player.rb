require 'csv'
require 'username_lib'

class Player < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  default_scope { order(rank: :asc) }

  searchkick callbacks: :async, word_start: [:full_name, :username]

  before_validation :gen_username, on: :create

  has_many :games_players, class_name: 'GamesPlayer', dependent: :nullify
  has_many :games, through: :games_players
  has_many :referees, dependent: :nullify
  has_many :games, through: :referees
  has_many :players_venues, class_name: 'PlayersVenue', dependent: :nullify
  has_many :venues, through: :players_venues
  has_many :players_regions, class_name: 'PlayersRegion', dependent: :nullify
  has_many :regions, through: :players_regions
  has_many :players_seasons, class_name: 'PlayersSeason', dependent: :nullify
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
              with: /\A[a-z0-9-]*\z/,
              message: 'may use numbers, letters, underscores (_), and hyphens (-)'
            },
            length: { minimum: 2 }

  validates :first_name, :last_name,
            presence: true,
            format: {
              with: /\A[a-zA-Z][a-zA-Z-]*[a-zA-Z]\z/,
              message: 'may use letters and hyphens (-)'
            },
            length: { maximum: 64 }

  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :notify_promotional, :notify_events, presence: true

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            allow_nil: true,
            allow_blank: true,
            uniqueness: true


  def to_param
    username
  end


  def search_data
    {
      full_name: self.full_name,
      username: "@#{self.username}",
      rank: self.rank
    }
  end

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

  def award (achievement, level=0)
    if awarded? achievement
      a = achievements.find_by type: achievement.sti_name
      a.level = level
      a.save
    else
      self.achievements << achievement.new(level: level)
    end
  end

  def awarded?(achievement)
    achievements.exists? type: achievement.sti_name
  end

  def gen_username
    self.username = generate_username(first_name, last_name)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.to_csv
    attributes = %w(first_name last_name email)

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |player|
        csv << player.attributes
      end
    end
  end

  def recent_games
    GamesPlayer.includes(game: [:venue]).where(player: self).reorder(created_at: :desc).limit(25)
  end
end
