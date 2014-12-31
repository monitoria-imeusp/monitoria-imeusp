class UsersController < ApplicationController
  authorize_resource

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      authorization_user
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def index
  end

  def edit
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      authorization_user
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def update
    @user = User.find(params[:id])
    authorization_user
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      sign_in  @user, :bypass => true
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorization_user
    @user.student do |s|
      s.destroy
    end
    @user.destroy

    redirect_to root_path
  end

  private

  def authorization_user
    if user_signed_in? and current_user.student? and (not @user.student? or @user.id != current_user.id)
      raise CanCan::AccessDenied.new()
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation,
                                 :nusp, :email)
  end
end
