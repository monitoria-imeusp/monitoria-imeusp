class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def usp
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth

    if @user.student? and auth.info.link == :student
      #this will throw if @user is not activated
      sign_in_and_redirect @user, :event => :authentication
    else
      if auth.info.link == :student
        sign_in @user
        redirect_to new_student_path
      end
    end
  end
end
