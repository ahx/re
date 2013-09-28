class TrackersController < ApplicationController
  before_action :require_api_authentication, only: :create

  def create
    tracker = Tracker.create!(message_token: SecureRandom.uuid,
      recipient: params[:recipient],
      subject: params[:subject],
      sender: current_api_user.email)
    render text: %(<img src="http://example.com/tracker/#{tracker.message_token}/tracker.gif">)
  end

  def show
    tracker = Tracker.where(message_token: params[:id]).first!
    ReceiptMailer.read_confirmation(tracker).deliver
    render status: :ok
  end

  private

  def require_api_authentication
    if current_api_user.blank?
      render status: 401
    end
  end

  def current_api_user
    User.where(api_key: params[:api_key]).first
  end
end
 
