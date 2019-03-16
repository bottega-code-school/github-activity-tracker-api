class Account < ApplicationRecord
  include Github
  validates_presence_of :login, :city, :state, :postal
  validate :unique_login_for_user

  belongs_to :user
  has_many :events, dependent: :destroy

  after_create :build_events

  private

    def build_events
      # TODO
      event_query = Github.fetch_events(self.login)
    end

    def unique_login_for_user
      if self.user.accounts.pluck(:login).include?(self.login)
        errors.add(:login, "username was already added")
      end
    end
end
