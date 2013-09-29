module ApplicationHelper
  def gravatar_url_for(email, options = { size: 40 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
