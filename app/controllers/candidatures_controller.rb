class CandidaturesController < ApplicationController
  authorize_resource
  before_action :set_candidature, only: [:show, :download_transcript, :edit, :update, :destroy]

  # GET /candidatures
  # GET /candidatures.json
  def index
    @candidatures_filtered = {}
    if student_signed_in?
      @semesters = Semester.all_open.map do |semester|
        { get: semester, valid: (not already_for_semester?(current_student.id, semester.id)) }
      end
    end
    Department.all.each do |dep|
      @candidatures_filtered[dep.code] = []
    end
    if admin_signed_in? or (professor_signed_in? and current_professor.hiper_professor?) or secretary_signed_in?
      Candidature.all.each do |candidature|
        @candidatures_filtered[candidature.main_department.code].push(candidature)
      end
    elsif professor_signed_in? and current_professor.super_professor?
      Candidature.all.each do |candidature|
        if candidature.main_department == current_professor.department
          @candidatures_filtered[candidature.main_department.code].push(candidature)
        end
      end
    elsif student_signed_in?
      Candidature.all.each do |candidature|
        if candidature.student_id == current_student.id
          @candidatures_filtered[candidature.main_department.code].push(candidature)
        end
      end
    else
      redirect_to root_path
    end
  end

  # GET /candidatures/1
  # GET /candidatures/1.json
  def show
    authorization_student
  end

  def download_transcript
    download
  end

  # GET /candidatures/2014/new
  def new
    @candidature = Candidature.new
    @semester = Semester.find(params[:id])
  end

  # GET /candidatures/1/edit
  def edit
    authorization_student
  end

  # POST /candidatures
  # POST /candidatures.json
  def create
    params[:candidature][:student_id] = current_student.id
    @candidature = Candidature.new(candidature_params)
    respond_to do |format|
<<<<<<< HEAD
      if already_for_semester? @candidature.student_id, @candidature.semester_id
        @candidature.errors.add(:semester_id, t('errors.models.candidature.toomany'))
        format.html { render action: 'new' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      elsif @candidature.save
=======
      if @candidature.save
>>>>>>> [fix_issue_47] Não mais limita a escolha de cursos na candidatura
        BackupMailer.new_candidature(@candidature).deliver
        format.html { redirect_to @candidature, notice: 'Candidatura criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @candidature }
      else
        format.html { render action: 'new'}
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidatures/1
  # PATCH/PUT /candidatures/1.json
  def update
    authorization_student
    respond_to do |format|
      if @candidature.update(candidature_params)
        BackupMailer.edit_candidature(@candidature).deliver
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
    authorization_student
    BackupMailer.delete_candidature(@candidature).deliver
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

  def authorization_student
    if student_signed_in? and @candidature.student_id != current_student.id
      raise CanCan::AccessDenied.new()
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidature_params
    params.require(:candidature).permit(
      :daytime_availability, :nighttime_availability, :time_period_preference,
      :course1_id, :course2_id, :course3_id, :course4_id, :student_id, :semester_id, 
      :observation, :transcript_file_path
    )
  end

  def candidature_of_department?(professor, candidature)
    course1 = Course.where(id: candidature.course1_id).take
    if(course1.department == professor.department)
      return true
    end
    return false
  end

  def already_for_semester? student_id, semester_id
    Candidature.where(student_id: student_id, semester_id: semester_id).any?
  end

end
