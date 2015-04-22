class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def usp
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth
    if @user.student? and auth.info.link == :student
      sign_in_and_redirect @user, :event => :authentication
    elsif auth.info.link == :student
      sign_in @user
      redirect_to new_student_path
    elsif auth.info.link == :teacher  
      sign_in @user
      redirect_to edit_professor_path(@user.professor)
    elsif @user.professor? and auth.info.link == :teacher
      sign_in_and_redirect @user, :event => :authentication # ? 
    else
      raise
    end
  end

end
