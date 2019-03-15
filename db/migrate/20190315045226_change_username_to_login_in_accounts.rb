class ChangeUsernameToLoginInAccounts < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :username, :login
  end
end
