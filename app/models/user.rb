class User < ActiveRecord::Base
  validates :email, :api_key, presence: true
  mount_uploader :signature_image, SignatureImageUploader

  before_validation :generate_api_key!, on: :create

  def generate_api_key!
    self.api_key = SecureRandom.uuid
  end
end
