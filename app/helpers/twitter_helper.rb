module TwitterHelper
  def twitter_profile_url(user)
    "http://twitter.com/#{user.login}"
  end

  def twitter_name(user, *options)
    if options.include? :link
      link_to("#{profile_image(user)} #{twitter_name(user)}", twitter_profile_url(user))
    else
      "@#{user.login}"
    end
  end

  def profile_image(user, options = {})
    alt = "#{user.name} (@#{user.login})"
    image_tag(user.profile_image_url, :alt => alt, :title => alt, :size => "50x50")
  end
  
end
