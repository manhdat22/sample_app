module UsersHelper
  def gravatar_for user, size: Settings.user.gravatar_default_size
    gravatar_email = user.email.downcase
    gravatar_id = Digest::MD5::hexdigest gravatar_email
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
