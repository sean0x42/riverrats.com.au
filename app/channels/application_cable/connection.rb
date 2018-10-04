# frozen_string_literal: true

module ApplicationCable
  # Application wide connection
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_verified_player
    end

    protected

    # Checks whether a player is authenticated with devise
    def find_verified_player
      if (verified_player = env['warden'].user)
        verified_player
      else
        reject_unauthorized_connection
      end
    end
  end
end
