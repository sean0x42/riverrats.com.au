class GameObserver < ActiveRecord::Observer

  def after_create (game)
  end

  def after_update (game)
    # Check achievements
  end

end
