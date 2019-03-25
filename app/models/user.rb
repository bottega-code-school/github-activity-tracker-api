class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true

  has_many :accounts, dependent: :destroy

  def self.accounts_by_state
    self.accounts.group(&:state)
  end
end
