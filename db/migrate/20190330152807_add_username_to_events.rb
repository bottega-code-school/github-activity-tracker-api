class AddUsernameToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :username, :string
  end
end
