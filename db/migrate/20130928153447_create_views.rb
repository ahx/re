class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :tracker_id
      t.string :request_ip
      t.string :user_agent
      t.timestamps
    end

    add_index :views, :tracker_id
  end
end
