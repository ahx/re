class AddUserIdToTrackers < ActiveRecord::Migration
  def change
    add_column :trackers, :user_id, :integer
  end
end
