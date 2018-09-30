# frozen_string_literal: true

# A lib for calculating and dealing with scores
module ScoreLib
  SCORE_MAP = {
    0 => 1000,
    1 => 750,
    2 => 600,
    3 => 500,
    4 => 400,
    5 => 300,
    6 => 200,
    7 => 150,
    8 => 150,
    9 => 150
  }.freeze

  def calculate_score(position)
    if SCORE_MAP.key?(position)
      SCORE_MAP[position]
    else
      50
    end
  end
end
