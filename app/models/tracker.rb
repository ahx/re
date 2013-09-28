class Tracker < ActiveRecord::Base
  has_many :views

  validates_presence_of :message_token, :sender, :recipient
end
