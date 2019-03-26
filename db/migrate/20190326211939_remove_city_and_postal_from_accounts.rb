class RemoveCityAndPostalFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :postal, :string
    remove_column :accounts, :city, :string
  end
end
