module ApplicationHelper
  def gravatar_url_for(email, options = { size: 50 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def signature_image_url_for(user)
    return nil unless user
    if user.signature_image_setting == "custom" && user.signature_image.present?
      user.signature_image.url(:mini)
    elsif user.signature_image_setting == "gravatar"
      gravatar_url_for(user.email)
    else
      nil
    end
  end
end
