class ChangelogsDateUnique < ActiveRecord::Migration[6.1]
  def change
    remove_index :logs, :date
    add_index :logs, [:user_id, :date], unique: true
  end
end
