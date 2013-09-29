module ApplicationHelper
  module_function

  def gravatar_url_for(email, options = { size: 50 })
    Gravatar.new(email).image_url(options)
  end

  def signature_image_url_for(user)
    return nil unless user
    if user.signature_image_setting == "gravatar"
      gravatar_url_for(user.email)
    elsif user.signature_image_setting == "custom"
      user.signature_image.url(:mini)
    else
      nil
    end
  end
end
