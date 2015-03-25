class ProfessorsController < ApplicationController
  authorize_resource
  before_action :redirect_if_not_exists, only: [:show, :edit, :change_password, :update, :destroy]

  def new
    @professor = Professor.new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @professor = Professor.new(professor_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    @user.skip_confirmation_notification!

    if @professor.valid? and @user.save
      @professor.user_id = @user.id
      if @professor.save
        @user.send_confirmation_instructions  
        redirect_to @user
      else
        render 'new'
      end
    else
      respond_to do |format|
        format.html { render action: 'new'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_superprofessor
    @professor = Professor.find(params[:id])
    @professor.professor_rank = 1
    respond_to do |format|
      if @professor.save
        format.html {redirect_to @professor.user, notice: @professor.name.to_s + ' é agora um Super-professor'}
      else
        format.html {render @professor.user}
      end
    end
  end

  def index
    @professors = Professor.all
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def update
    @professor = Professor.find(params[:id])
    if @professor.update(professor_params)
      redirect_to @professor.user
    else
      # Never managed to reach here
      render 'edit'
    end
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
    if user_signed_in?
      current_user.professor do |professor|
        raise CanCan::AccessDenied.new unless @professor.id == professor.id
      end
      current_user.student do |student|
        raise CanCan::AccessDenied.new
      end
    end
  end

  def professor_params
    params.require(:professor).permit(:department_id, :professor_rank)
  end

  def user_params
    params.require(:user).permit(:name, :nusp, :email)
  end
end
