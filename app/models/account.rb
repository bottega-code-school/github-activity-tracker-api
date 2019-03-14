class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :username

  validate :unique_username_for_user

  private

    def unique_username_for_user
      puts "unique_username_for_user" * 500, self.username, "unique_username_for_user" * 500
      puts "collection" * 500, self.user.accounts.pluck(:username), "collection" * 500
      if self.user.accounts.pluck(:username).include? self.username
        false
      else
        true
      end
    end
end
