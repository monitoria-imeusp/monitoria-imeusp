class CandidaturesController < ApplicationController
  before_action :set_candidature, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_student!, only: [:new, :create, :edit, :update, :destroy]

  # GET /candidatures
  # GET /candidatures.json
  def index
    if admin_signed_in? or (professor_signed_in? and current_professor.super_professor?) or secretary_signed_in?
      @candidatures_filtered = Candidature.all
    elsif student_signed_in?
      @candidatures_filtered = Candidature.where("student_id = ?", current_student.id)
    else
      redirect_to root_path
    end
  end

  # GET /candidatures/1
  # GET /candidatures/1.json
  def show
  end

  # GET /candidatures/new
  def new
    @candidature = Candidature.new
  end

  # GET /candidatures/1/edit
  def edit
  end

  # POST /candidatures
  # POST /candidatures.json
  def create
    params[:candidature][:student_id] = current_student.id
    @candidature = Candidature.new(candidature_params)

    respond_to do |format|
      if @candidature.save
        format.html { redirect_to @candidature, notice: 'Candidatura criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @candidature }
      else
        format.html { render action: 'new' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidatures/1
  # PATCH/PUT /candidatures/1.json
  def update
    respond_to do |format|
      if @candidature.update(candidature_params)
        format.html { redirect_to @candidature, notice: 'Candidatura atualizada com sucesso.' }
        format.json { render action: 'show', status: :ok, location: @candidature }
      else
        format.html { render action: 'edit' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidatures/1
  # DELETE /candidatures/1.json
  def destroy
    @candidature.destroy
    respond_to do |format|
      format.html { redirect_to candidatures_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_candidature
    @candidature = Candidature.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidature_params
      params.require(:candidature).permit(:daytime_availability, :nighttime_availability, :time_period_preference, :course1_id, :course2_id, :course3_id, :student_id)
    end
end
