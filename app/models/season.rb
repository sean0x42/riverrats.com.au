class Season < ApplicationRecord

  has_many :players_seasons,
           class_name: 'PlayersSeasons',
           dependent: :nullify
  has_many :players, through: :players_seasons

  validates :start_at, :end_at,
            presence: true

  def name
    "Season #{quarter}, #{start_at.year}"
  end

  def quarter
    (Date.today.month / 3.0).ceil
  end

end
