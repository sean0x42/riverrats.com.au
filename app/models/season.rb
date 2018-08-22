class Season < ApplicationRecord
  has_many :players_seasons, class_name: 'PlayersSeason', dependent: :nullify
  has_many :players, through: :players_seasons

  validates :start_at, :end_at, presence: true
  validate :start_at_must_be_before_end_at

  def name
    "Season #{quarter}, #{start_at.year}"
  end

  def quarter
    (start_at.month / 3.0).ceil
  end

  def start_at_must_be_before_end_at
    return unless start_at.present? && end_at.present?
    if start_at > end_at
      errors.add(:start_at, 'can\'t be after the end date.')
    end
  end

  def paginated_players(page)
    PlayersSeason.includes(:player).where(season: self).page(page).per(25)
  end
end
