class HomeController < ApplicationController
  before_action :authenticate_dump!, :only => [:dump]

  def index
  end

  def dump
    database_config = Rails.configuration.database_configuration
    if database_config[Rails.env]["adapter"] == "postgresql"
      @dumpfile = "dumpfiles/dump-#{Time.now.strftime "%Y%m%d%H%M%S"}"
      `pg_dump > #{@dumpfile}`
      @dump_successful = true
    else
      @dump_successful = false
    end
  end

  def sys
  end

  def prof
    redirect_to new_professor_session_path
  end

  protected

  def authenticate_dump!
    unless admin_signed_in? or (professor_signed_in? and current_professor.super_professor) or secretary_signed_in?
      redirect_to root_path
    end
  end
end
