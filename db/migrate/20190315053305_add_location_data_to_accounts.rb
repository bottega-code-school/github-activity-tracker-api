class AddLocationDataToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :city, :string
    add_column :accounts, :state, :string
    add_column :accounts, :postal, :string
  end
end
