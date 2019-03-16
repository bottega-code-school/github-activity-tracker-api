class AddCommitCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :commit_count, :integer
  end
end
