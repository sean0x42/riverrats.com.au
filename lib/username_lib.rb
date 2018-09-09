module UsernameLib
  def self.generate_username(first_name, last_name)
    standard = "#{first_name}#{last_name}"
    username = standard.downcase

    # Keep adding a random digit to the end of the players name until it's unique
    while Player.exists?(username: username)
      username = "#{standard}#{1 + Random.rand(99)}"
    end

    username
  end
end