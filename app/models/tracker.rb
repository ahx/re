class Tracker < ActiveRecord::Base
  has_many :views
  belongs_to :user

  validates_presence_of :message_token, :sender, :recipient
end
