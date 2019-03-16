class Account < ApplicationRecord
  include Github
  validates_presence_of :login, :city, :state, :postal
  validate :unique_login_for_user

  belongs_to :user
  has_many :events, dependent: :destroy

  after_create :build_events

  private

    def build_events
      event_query = Github.fetch_events(self.login)
      puts "DATA" * 500, event_query.body, "data" * 500
      JSON.parse(event_query.body).each do |event|
        Event.create!(
          account: self,
          repo_name: event["repo"]["name"],
          repo_url:  event["repo"]["url"],
          date: event["created_at"].to_date,
          message: event["payload"]["commits"][0]["message"],
          commit_count: event["payload"]["size"]
        )
      end
    end

    def unique_login_for_user
      if self.user.accounts.pluck(:login).include?(self.login)
        errors.add(:login, "username was already added")
      end
    end
end
