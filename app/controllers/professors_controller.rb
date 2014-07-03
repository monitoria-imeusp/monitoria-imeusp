class ProfessorsController < ApplicationController
  before_action :authenticate_admin!, :only => [:new, :create, :destroy]
  before_action :authenticate_edit!,  :only => [:edit, :update]

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    generated_password = Devise.friendly_token.first(8)
    @professor.password = generated_password
    if @professor.save
      redirect_to @professor
    else
      render 'new'
    end
  end

  def show
    redirect_if_not_exists
  end

  def index
    @professors = Professor.all
  end

  def edit
    redirect_if_not_exists
  end

  def change_password
    redirect_if_not_exists
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

  def redirect_if_not_exists
    if Professor.exists?(params[:id])
      @professor = Professor.find(params[:id])
    else
      redirect_to professors_path
    end
  end

  def professor_params
    params.require(:professor).permit(:name, :nusp,:email,
      :department_id, :professor_rank, :password, :password_confirmation)
  end
end
