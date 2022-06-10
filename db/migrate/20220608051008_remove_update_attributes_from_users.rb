class RemoveUpdateAttributesFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :update_attributes, :string
  end
end
