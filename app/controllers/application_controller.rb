class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_super_professor?
  helper_method :current_hiper_professor?
  helper_method :current_professor?
  helper_method :current_student?

  rescue_from CanCan::AccessDenied do |exception|
    #render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false    

    redirect_to '/403'
  end

  def current_ability
      @current_ability ||= ::Ability.new(
        if user_signed_in?
          current_user
        elsif secretary_signed_in?
          current_secretary
        elsif admin_signed_in?
          current_admin
        else
          nil
        end
      )
  end

  def current_super_professor?
    user_signed_in? and current_user.super_professor?
  end

  def current_hiper_professor?
    user_signed_in? and current_user.hiper_professor?
  end

  def current_professor?
    user_signed_in? and current_user.professor?
  end

  def current_student?
    user_signed_in? and current_user.student?
  end

end
