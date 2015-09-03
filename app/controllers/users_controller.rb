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
    @users = User.all
  end
  
  def destroy
    @user = User.find(params[:id])
    authorization_user_destroy
    @user.student do |s|
      s.destroy
    end
    @user.professor do |p|
      p.destroy
    end
    @user.destroy

    redirect_to root_path
  end

  private

  def authorization_user
    if user_signed_in?
      if not current_user.student? and (not current_user.professor? or current_user.professor.dirty)
        raise CanCan::AccessDenied.new
      end
      if current_user.student? and (not @user.student? or @user.id != current_user.id)
        raise CanCan::AccessDenied.new
      end
      current_user.professor do |professor|
        raise CanCan::AccessDenied.new unless professor.super_professor? or @user.id == current_user.id
      end
    end
  end

  def authorization_user_destroy
    if user_signed_in?
      if current_user.student?
        raise CanCan::AccessDenied.new
      end
      current_user.professor do |professor|
        raise CanCan::AccessDenied.new unless professor.super_professor? or @user.id == current_user.id
      end
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation,
                                 :nusp, :email)
  end
end
