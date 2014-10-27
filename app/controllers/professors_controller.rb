class ProfessorsController < ApplicationController
  authorize_resource
  before_action :redirect_if_not_exists, only: [:show, :edit, :change_password, :update, :destroy]

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

  def make_superprofessor
    @professor = Professor.find(params[:id])
    @professor.professor_rank = 1
    respond_to do |format|
      if @professor.save
        format.html {redirect_to @professor, notice: @professor.name.to_s + ' é agora um Super-professor'}
      else
        format.html {render @professor}
      end
    end
  end

  def show
  end

  def index
    @professors = Professor.all
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def update
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

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy

    redirect_to professors_path
  end

  def change_password
  end

  private
  def redirect_if_not_exists
    if Professor.exists?(params[:id])
      @professor = Professor.find(params[:id])
      authorization_professor
    else
      redirect_to professors_path
    end
  end

  def authorization_professor
    if (professor_signed_in? and current_professor.professor_rank == 0) and @professor.id != current_professor.id
      raise CanCan::AccessDenied.new()
    end
  end

  def professor_params
    params.require(:professor).permit(:name, :nusp,:email,
      :department_id, :professor_rank, :password, :password_confirmation)
  end
end
