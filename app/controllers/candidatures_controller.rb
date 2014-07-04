class CandidaturesController < ApplicationController
  authorize_resource
  before_action :set_candidature, only: [:show, :download_transcript, :edit, :update, :destroy]

  # GET /candidatures
  # GET /candidatures.json
  def index
    @candidatures_filtered = {}
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
  end

  def download_transcript
    download
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
    uploaded = upload
    @candidature = Candidature.new(candidature_params)
    respond_to do |format|
      if uploaded
        if @candidature.save
          BackupMailer.new_candidature(@candidature).deliver
          format.html { redirect_to @candidature, notice: 'Candidatura criada com sucesso.' }
          format.json { render action: 'show', status: :created, location: @candidature }
        else
          format.html { render action: 'new' }
          format.json { render json: @candidature.errors, status: :unprocessable_entity }
        end
      else
        @candidature.errors.add :transcript_file_path, "precisa ser um arquivo pdf"
        format.html { render action: 'new' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidatures/1
  # PATCH/PUT /candidatures/1.json
  def update
    uploaded = upload
    respond_to do |format|
      if uploaded
        if @candidature.update(candidature_params)
          BackupMailer.edit_candidature(@candidature).deliver
          format.html { redirect_to @candidature, notice: 'Candidatura atualizada com sucesso.' }
          format.json { render action: 'show', status: :ok, location: @candidature }
        else
          format.html { render action: 'edit' }
          format.json { render json: @candidature.errors, status: :unprocessable_entity }
        end
      else
        @candidature.errors.add :transcript_file_path, "precisa ser um arquivo pdf"
        format.html { render action: 'edit' }
        format.json { render json: @candidature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidatures/1
  # DELETE /candidatures/1.json
  def destroy
    BackupMailer.delete_candidature(@candidature).deliver
    @candidature.destroy
    respond_to do |format|
      format.html { redirect_to candidatures_url }
      format.json { head :no_content }
    end
  end

  protected
  def upload
      uploaded_io = params[:candidature][:transcript_file_path]
      nusp = current_student.nusp
      new_name = (Time.now.strftime '%Y%m%d_' + nusp) + ".pdf"
      path = Candidature.path_to_transcript new_name
      params[:candidature][:transcript_file_path] = new_name
      if uploaded_io and  uploaded_io.content_type == "application/pdf"
          File.open(path, 'wb') do |file|
                    file.write(uploaded_io.read)
          end
          true
      else
          false
      end
  end

  def download
    send_file @candidature.path_to_transcript,
              filename: @candidature.generate_transcript_filename,
              type: "application/pdf"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_candidature
    @candidature = Candidature.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def candidature_params
    params.require(:candidature).permit(:daytime_availability, :nighttime_availability, :time_period_preference, :course1_id, :course2_id, :course3_id, :student_id, :observation, :transcript_file_path)
  end

  def candidature_of_department?(professor, candidature)
    course1 = Course.where(id: candidature.course1_id).take
    if(course1.department == professor.department)
      return true
    end
    return false
  end

end
