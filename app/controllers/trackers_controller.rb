class TrackersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_authentication, only: :create

  def create
    @tracker = Tracker.create!(message_token: SecureRandom.uuid,
      recipient: params[:recipient],
      subject: params[:subject],
      sender: current_api_user.email)
    render layout: false
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
      render text: 'not allowed', status: 401
    end
  end

  def current_api_user
    User.where(api_key: params[:api_key]).first
  end
end
