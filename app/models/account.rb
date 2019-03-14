class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :username

  validate :unique_username_for_user

  private

    def unique_username_for_user
      if self.user.accounts.pluck(:username).include?(self.username)
        errors.add(:username, "username was already added")
      end
    end

    def login
      self.username
    end
end
