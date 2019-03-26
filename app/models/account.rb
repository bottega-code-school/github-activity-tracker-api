class Account < ApplicationRecord
  include Github
  validates_presence_of :login, :state
  validate :unique_login_for_user

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
            commit_count: event["payload"]["size"]
          )
        end
      end
    end

    def unique_login_for_user
      if self.user.accounts.pluck(:login).include?(self.login)
        errors.add(:login, "username was already added")
      end
    end
end
