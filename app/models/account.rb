class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :login, :city, :state, :postal

  validate :unique_login_for_user

  has_many :events, dependent: :destroy

  private

    def unique_login_for_user
      if self.user.accounts.pluck(:login).include?(self.login)
        errors.add(:login, "username was already added")
      end
    end
end
