class HelpStudentsController < ApplicationController
  def index
    render params[:id]
  end
end
