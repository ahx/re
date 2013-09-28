class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.string :sender
      t.string :recipient
      t.string :subject
      t.string :message_token

      t.timestamps
    end
  end
end
