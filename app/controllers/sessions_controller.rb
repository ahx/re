class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    respond_to_browserid
    if browserid_email.present? && current_user.blank?
      create_new_persona_user
    end
  end

  def destroy
    logout_browserid
    head :ok
  end

  private

  def create_new_persona_user
    User.create!(email: browserid_email) # Fails loudly!
  end

end
