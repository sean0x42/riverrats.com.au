# frozen_string_literal: true

# A lib for generating player usernames
module UsernameLib
  def self.generate_username(first_name, last_name)
    standard = "#{first_name}#{last_name}".downcase
    username = standard

    # Keep adding a random digit to the end of the players name until it's unique
    while Player.exists?(username: username)
      username = "#{standard}#{Random.rand(1..99)}"
    end

    username
  end
end
