class HelpProfessorsController < ApplicationController
  def index
    render params[:id]
  end
end
