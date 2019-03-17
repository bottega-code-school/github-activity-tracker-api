class AddGithubEventIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :github_event_id, :text
  end
end
