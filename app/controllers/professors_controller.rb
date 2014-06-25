class ProfessorsController < ApplicationController
  before_action :authenticate_admin!, :only => [:new, :create, :destroy]
  before_action :authenticate_edit!,  :only => [:edit, :update]

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      redirect_to @professor
    else
      render 'new'
    end
  end

  def show
    if Professor.exists?(params[:id])
      @professor = Professor.find(params[:id])
    else
      redirect_to professors_path
    end
  end

  def index
    @professors = Professor.all
  end

  def edit
    if Professor.exists?(params[:id])
      @professor = Professor.find(params[:id])
    else
      redirect_to professors_path
    end
  end

  def update
    if not Professor.exists? params[:id]
      # TODO alert failure
      redirect_to professors_path
      return
    end
    @professor = Professor.find(params[:id])
    if params[:professor][:password].blank? && params[:professor][:password_confirmation].blank?
      params[:professor].delete(:password)
      params[:professor].delete(:password_confirmation)
    end
    if @professor.update(professor_params)
      sign_in  @professor, :bypass => true
      redirect_to @professor
    else
      render 'edit'
    end
  end

  protected

  def authenticate_edit!
    unless professor_signed_in? and (current_professor.id == params[:id].to_i)
      redirect_to root_path
    end
  end

  private
  def professor_params
    params.require(:professor).permit(:name, :nusp, :password, :password_confirmation, :department_id, :email, :super_professor)
  end
end
