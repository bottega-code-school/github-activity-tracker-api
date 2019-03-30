class Account < ApplicationRecord
  include Github
  validates_presence_of :login, :state
  validate :unique_login_for_user
  validate :state_abbr_exists

  belongs_to :user
  has_many :events, dependent: :destroy

  after_create :build_events

  private

    def build_events
      event_query = Github.fetch_events(self.login)
      JSON.parse(event_query.body).each do |event|
        if event["type"] == "PushEvent"
          Event.create!(
            account: self,
            github_event_id: event["id"],
            repo_name: event["repo"]["name"],
            repo_url:  event["repo"]["url"],
            date: event["created_at"].to_date,
            message: event["payload"]["commits"][0]["message"],
            commit_count: event["payload"]["size"],
            username: self.login
          )
        end
      end
    end

    def unique_login_for_user
      if self.user.accounts.pluck(:login).include?(self.login)
        errors.add(:login, "username was already added")
      end
    end

    def state_abbr_exists
      state_abbr_list = %w{AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY}
      unless state_abbr_list.include?(self.state)
        errors.add(:state, "State does not exist")
      end
    end
end
