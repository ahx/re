module ApplicationHelper
  module_function

  def gravatar_url_for(email, options = { size: 50 })
    Gravatar.new(email).image_url(options)
  end

end
