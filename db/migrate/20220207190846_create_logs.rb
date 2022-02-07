class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.bigint :user_id
      t.date :date
      t.integer :sleep
      t.boolean :meal
      t.boolean :medicine
      t.string :bathe
      t.string :go_out
      t.text :memo

      t.timestamps
    end
  end
end
