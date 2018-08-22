module UsernameLib
  def generate_username(first_name, last_name)
    username = "#{first_name}#{last_name}".downcase
    while Player.exists? username: username
      username = "#{first_name}#{last_name}#{1 + Random.rand(99)}"
    end
    username
  end
end