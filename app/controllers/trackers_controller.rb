class TrackersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_authentication, only: :create

  def create
    @tracker = Tracker.create!(message_token: SecureRandom.uuid,
      user: current_api_user,
      recipient: params[:recipient],
      subject: params[:subject],
      sender: current_api_user.email)
    render layout: false
  end

  def show
    tracker = Tracker.where(message_token: params[:id]).first!
    view = View.create!(tracker: tracker, request_ip: request.remote_ip, user_agent: request.user_agent)
    ReceiptMailer.read_confirmation(tracker, view).deliver

    # FIXME Spec this
    if tracker.user.signature_image_setting == 'gravatar'
      redirect_to ApplicationHelper.gravatar_url_for(current_user.email)
    else
      image_url = tracker.user.signature_image.versions[:mini].path
      send_file image_url || Rails.root.join('app/assets/images/fallback/tracker.png')
    end
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
