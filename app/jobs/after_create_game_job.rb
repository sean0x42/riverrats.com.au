class AfterCreateGameJob < ApplicationJob
  queue_as :default

  def perform (game)

  end

end
