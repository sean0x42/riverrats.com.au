# frozen_string_literal: true

require 'csv'
require 'username_lib'

# Represents a single player
class Player < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  default_scope { order(rank: :asc) }

  searchkick callbacks: :async, word_start: %i[full_name username]

  before_validation :gen_username, on: :create
  before_save :nil_if_blank, :titleize_names

  with_options dependent: :nullify, inverse_of: :player do
    has_many :games_players,   class_name: 'GamesPlayer'
    has_many :players_venues,  class_name: 'PlayersVenue'
    has_many :players_regions, class_name: 'PlayersRegion'
    has_many :players_seasons, class_name: 'PlayersSeason'
    has_many :comments
  end

  has_many :games, through: :games_players
  has_many :referees, dependent: :nullify
  has_many :games, through: :referees
  has_many :venues, through: :players_venues
  has_many :regions, through: :players_regions
  has_many :seasons, through: :players_seasons
  has_many :achievements, dependent: :destroy

  attr_writer :login

  with_options presence: true do
    validates :username,
              uniqueness: { case_sensitive: false },
              length: { minimum: 2 },
              format: {
                with: /\A[a-z0-9-]*\z/,
                message: 'may use numbers, letters, underscores (_), and hyphens (-)'
              }
    validates :notify_promotional, :notify_events
  end

  with_options length: { maximum: 64 },
               format: {
                 with: /\A[a-zA-Z][a-zA-Z-]*[a-zA-Z]\z/,
                 message: 'may use letters and hyphens (-)'
               } do
    validates :first_name, :last_name, presence: true
    validates :nickname, allow_nil: true, allow_blank: true
  end

  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    allow_nil: true, allow_blank: true, uniqueness: true

  def to_param
    username
  end

  def search_data
    {
      full_name: full_name,
      username: "@#{username}",
      is_admin: admin?,
      is_developer: developer?
    }
  end

  def full_name
    if nickname.nil?
      "#{first_name} #{last_name}"
    else
      "#{first_name} '#{nickname}' #{last_name}"
    end
  end

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def award(achievement, level = 0)
    if awarded? achievement
      a = achievements.find_by type: achievement.sti_name
      a.level = level
      a.save
    else
      achievements << achievement.new(level: level)
    end
  end

  def awarded?(achievement)
    achievements.exists? type: achievement.sti_name
  end

  def gen_username
    self.username = UsernameLib.generate_username(first_name, last_name)
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.to_csv
    attributes = %w[first_name last_name email]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |player|
        csv << player.attributes
      end
    end
  end

  def recent_games
    GamesPlayer.includes(game: [:venue])
               .where(player: self)
               .reorder(created_at: :desc).limit(25)
  end

  def season_player
    PlayersSeason.find_by(player: self, season: Season.current)
  end

  def self.recent(days = 30)
    Player.where('created_at > ?', Time.zone.today - days.days)
  end

  def self.admins
    Player.where(admin: true).or(Player.where(developer: true))
  end

  protected

  def nil_if_blank
    %i[nickname email].each do |attribute|
      next if self[attribute].nil?

      self[attribute] = nil if self[attribute].blank?
    end
  end

  def titleize_names
    %i[first_name nickname last_name].each do |attribute|
      next if self[attribute].nil?

      self[attribute] = self[attribute].titleize
    end
  end
end
