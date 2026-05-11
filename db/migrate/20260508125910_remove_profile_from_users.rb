class RemoveProfileFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :profile, :string
  end
end
