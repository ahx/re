class SettingsController < ApplicationController
  before_action :require_authentication

  def show
  end

  def update
    current_user.update_attributes(user_params)
    flash[:notice] = "Einstellungen wurden gespeichert"
    redirect_to settings_path
  end

  private

  def user_params
    params.require(:user).permit(
      :signature_image_setting,
      :signature_image,
      :remove_signature_image
      )
  end
end
