class UsersController < ApplicationController
  authorize_resource

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      authorization_user
    else
      redirect_to users_path
    end
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authorization_user
    if user_signed_in? and current_user.student? and @user.id != current_user.id
      raise CanCan::AccessDenied.new()
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation,
                                 :nusp, :email)
  end
end
