class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :account, foreign_key: true
      t.string :repo_name
      t.string :repo_url
      t.datetime :date
      t.text :message

      t.timestamps
    end
  end
end
