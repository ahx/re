class AddSignatureImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signature_image, :string
    add_column :users, :signature_image_setting, :string
  end
end
