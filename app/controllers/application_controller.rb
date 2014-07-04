class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_ability
      @current_ability ||= ::Ability.new(
        if student_signed_in?
            current_student
        elsif secretary_signed_in?
          current_secretary
        elsif admin_signed_in?
          current_admin
        elsif professor_signed_in?
          current_professor
        else
          nil
        end
      )
  end
end
