class TrackersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_authentication, only: :create
  helper_method :client_ip

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
    unless params[:notrack]
      view = View.create!(tracker: tracker, request_ip: client_ip, user_agent: request.user_agent)
      ReceiptMailer.read_confirmation(tracker, view).deliver
    end
    # FIXME Spec this
    if tracker.user.signature_image_setting == 'gravatar'
      data = Gravatar.new(tracker.user.email).image_data(size: 50)
      send_data data, type: 'image/jpeg', disposition: 'inline'
      return
    end
    image_path = if tracker.user.signature_image_setting == 'custom'
      tracker.user.signature_image.versions[:mini].path
    else
      Rails.root.join('app/assets/images/fallback/tracker.png')
    end
    send_file(image_path, disposition: 'inline')
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

  def client_ip
    header_ip = request.env['HTTP_X_FORWARDED_FOR'].try(:split, ',').try(:first)
    header_ip || request.remote_ip
  end

end
