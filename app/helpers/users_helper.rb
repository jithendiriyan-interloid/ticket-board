module UsersHelper
  def user_avatar(user, classes = "")
    if user.avatar.attached? && user.avatar.blob.persisted?
      image_tag(url_for(user.avatar), class: classes)
    else
      image_tag("default_avatar.jpg", class: classes)
    end
  end
end