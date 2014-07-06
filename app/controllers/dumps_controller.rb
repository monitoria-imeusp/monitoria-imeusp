class DumpsController < ApplicationController
  authorize_resource 

  def index
    database_config = Rails.configuration.database_configuration
    if database_config[Rails.env]["adapter"] == "postgresql"
      @dumpfile = "dumpfiles/dump-#{Time.now.strftime "%Y%m%d%H%M%S"}"
      `pg_dump > #{@dumpfile}`
      @dump_successful = true
    else
      @dump_successful = false
    end
  end
end
