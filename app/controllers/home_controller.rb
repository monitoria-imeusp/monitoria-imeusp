class HomeController < ApplicationController
  def index
    if user_signed_in?
      if not current_user.student? and not current_user.professor?
        redirect_to '/students/new'
      elsif current_user.professor? and current_user.professor.dirty
        redirect_to edit_professor_path(current_user.professor)
      else
        @advises = Advise.all.order(:order)
      end
    else
      @advises = Advise.all.order(:order)
    end
  end

  def sys
  end

  def prof
  end
end
