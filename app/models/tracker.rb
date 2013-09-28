class Tracker < ActiveRecord::Base
  validates_presence_of :message_token, :sender, :recipient
end
