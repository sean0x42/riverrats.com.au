module ScoreLib
  def calculate_score(position)
    case (position + 1)
      when 1
        1000
      when 2
        750
      when 3
        600
      when 4
        500
      when 5
        400
      when 6
        300
      when 7
        200
      when 8..10
        150
      else
        50
    end
  end
end
