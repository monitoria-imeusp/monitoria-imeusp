class CandidaturesController < ApplicationController
  before_action :set_candidature, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_student!, only: [:new, :create, :edit, :update, :destroy]

  # GET /candidatures
  # GET /candidatures.json
  def index
    if admin_signed_in? or (professor_signed_in? and current_professor.hiper_professor?) or secretary_signed_in?
      @candidatures_filtered = Candidature.all
    elsif professor_signed_in? and current_professor.super_professor?
      @candidatures_filtered = (Candidature.all.map do |candidature| candidature end).keep_if do |candidature|
        candidature_of_department?(current_professor, candidature)
      end
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
    BackupMailer.delete_candidature(@candidature).deliver
    @candidature.destroy
    respond_to do |format|
      format.html { redirect_to candidatures_url }
      format.json { head :no_content }
    end
  end

  private
  def upload
      uploaded_io = params[:candidature][:transcript_file_path]
      nusp = current_student.nusp
      new_name = (Time.now.strftime '%Y%m%d_' + nusp) + ".pdf"
      path = Rails.root.join('public', 'uploads', 'transcripts', new_name)
      params[:candidature][:transcript_file_path] = path.to_s
      if uploaded_io and  uploaded_io.content_type == "application/pdf"
          File.open(path, 'wb') do |file|
                    file.write(uploaded_io.read)
          end
          true
      else
          false
      end
  end

  def download transcript_file_path
    send_data pdf,
      :filename => transcript_file_path,
      :type => "application/pdf"
  end

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
    if(candidature.course2_id != nil)
      course2 = Course.where(id: candidature.course2_id).take
      if(course2.department == professor.department)
        return true
      end
    end
    if(candidature.course3_id != nil)
      course3 = Course.where(id: candidature.course3_id).take
      if(course3.department == professor.department)
        return true
      end
    end
    return false
  end

end
