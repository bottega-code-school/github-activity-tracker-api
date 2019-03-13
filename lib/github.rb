module Github
  def self.api_credentials
    "client_id=#{Rails.application.credentials.github[:client_id]}&client_secret=#{Rails.application.credentials.github[:client_secret]}"
  end

  def self.username_search username
    HTTParty.get("https://api.github.com/users/#{username}?#{self.api_credentials}")
  end
end
