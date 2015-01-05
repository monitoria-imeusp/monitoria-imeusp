class HomeController < ApplicationController
  def index
    @advises = Advise.all.order(:order)
  end

  def sys
  end

  def prof
    redirect_to new_user_session_path
  end
end
