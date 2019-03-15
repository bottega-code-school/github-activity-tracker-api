class AddDataToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :avatar_url, :string
    add_column :accounts, :bio, :string
    add_column :accounts, :public_repos, :integer
    add_column :accounts, :public_gists, :integer
    add_column :accounts, :followers, :integer
    add_column :accounts, :following, :integer
    add_column :accounts, :member_since, :datetime
  end
end
