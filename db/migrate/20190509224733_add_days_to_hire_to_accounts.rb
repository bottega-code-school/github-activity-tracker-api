class AddDaysToHireToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :days_to_hire, :integer
  end
end
