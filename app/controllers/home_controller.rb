class HomeController < ApplicationController
  def index
    if user_signed_in?
      if not current_user.student? and not current_user.professor?
        redirect_to '/students/new'
      end
    end
    @advises = Advise.all.order(:order)
  end

  def sys
  end

  def prof
    redirect_to new_user_session_path
  end
end
