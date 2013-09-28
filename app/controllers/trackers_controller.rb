class TrackersController < ApplicationController
  before_action :require_api_authentication, only: :create

  def create
    tracker = Tracker.create!(message_token: SecureRandom.uuid,
      recipient: params[:recipient],
      subject: params[:subject],
      sender: current_api_user.email)
    render text: %(<img src="#{tracker_snippet_url(id: tracker.message_token)}" moz-do-not-send="true"">)
  end

  def show
    tracker = Tracker.where(message_token: params[:id]).first!
    view = View.create!(tracker: tracker, request_ip: request.remote_ip, user_agent: request.user_agent)
    ReceiptMailer.read_confirmation(tracker, view).deliver
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
