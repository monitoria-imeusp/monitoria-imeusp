module UserHelper

  def can_be_removed? user
    admin_signed_in? or secretary_signed_in? or (user_signed_in? and current_user.id == user.id)
  end

end
