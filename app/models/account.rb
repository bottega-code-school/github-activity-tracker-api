class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :username

  validate :unique_username_for_user

  private

    def unique_username_for_user
      if self.user.accounts.pluck(:username).include? self.username
        false
      else
        true
      end
    end
end
