class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.bigint :user_id, null: false
      t.date :date, null: false
      t.integer :sleep, null: false
      t.boolean :meal, default: false, null: false
      t.boolean :medicine, default: false, null: false
      t.string :bathe, null: false
      t.string :go_out, null: false
      t.text :memo

      t.timestamps
    end

    add_index :logs, :date, unique: true
  end
end
