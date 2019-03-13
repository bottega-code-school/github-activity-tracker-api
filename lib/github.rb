module Github
  def self.username_search username
    HTTParty.get("https://api.github.com/users/#{username}")
  end
end
