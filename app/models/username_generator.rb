class UsernameGenerator

  ###
  # Generates a unique username comprised of the player's
  # first name, last name, and a unique number.
  def self.generate (first_name, last_name)
    count = 0

    # Continue looping until we reach a unique username
    begin
      username = "#{first_name}#{last_name}#{count if count != 0}".downcase
      count += 1
    end while Player.exists?(username: username)

    username
  end

end