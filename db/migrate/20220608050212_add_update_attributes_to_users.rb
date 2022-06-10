class AddUpdateAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :update_attributes, :string
  end
end
