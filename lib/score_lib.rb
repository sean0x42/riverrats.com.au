# frozen_string_literal: true

# A lib for calculating and dealing with scores
module ScoreLib
  @score_map = {
    1 => 1000,
    2 => 750,
    3 => 600,
    4 => 500,
    5 => 400,
    6 => 300,
    7 => 200,
    8 => 150,
    9 => 150,
    10 => 150
  }.freeze

  def calculate_score(position)
    if @score_map.key?(position)
      @score_map[position]
    else
      50
    end
  end
end
