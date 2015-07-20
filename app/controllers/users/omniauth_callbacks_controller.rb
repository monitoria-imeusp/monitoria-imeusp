class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def usp
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth
    if @user.student? and auth.info.link == :student
      sign_in_and_redirect @user, :event => :authentication
    elsif auth.info.link == :student
      sign_in @user
      redirect_to new_student_path
    elsif (@user.professor? or auth.info.link == :teacher) and not @user.professor.dirty
      sign_in_and_redirect @user, :event => :authentication # ? 
    elsif auth.info.link == :teacher
      sign_in @user
      redirect_to edit_professor_path(@user.professor)
    else
      p "===> Unknown link! <==="
      p auth
      raise
    end
  end

end
