class AssistantRolesController < ApplicationController
  authorize_resource

  # GET /assistant_roles
  def index
    separate_by_semester AssistantRole.all    
    @current_semester_frequencies = AssistantFrequency.current_frequencies
    create_current_months
  end

  # GET /assistant_roles/for_professor/1
  def index_for_professor
    @professor = Professor.find(params[:professor_id])
    requests = RequestForTeachingAssistant.where(professor: @professor)
    separate_by_semester AssistantRole.where(request_for_teaching_assistant: requests)
  end

  def create
    @assistant_role = AssistantRole.new assistant_role_params
    if @assistant_role.save
      respond_to do |format|
        BackupMailer.new_assistant_role(@assistant_role, current_creator).deliver
        format.html { redirect_to @assistant_role.request_for_teaching_assistant, notice: 'Monitor eleito com sucesso.' }
        format.json { render action: 'show', status: :created, location: @assistant_role.request }
      end
    else
      respond_to do |format|
        format.html { redirect_to @assistant_role.request }
        format.json { render json: @assistant_role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if AssistantRole.exists? params[:id]
      @assistant_role = AssistantRole.find params[:id]
      BackupMailer.delete_assistant_role(@assistant_role, current_creator).deliver
      @assistant_role.destroy
      respond_to do |format|
        format.html { redirect_to assistant_roles_path }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to assistant_roles_path }
        format.json { head :no_content }
      end
    end
  end

  # POST /assistant_roles/notify_for_semester/1
  def notify_for_semester
    @semester = Semester.find(params[:semester_id])
    requests = RequestForTeachingAssistant.where(semester: @semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      NotificationMailer.acceptance_notification(assistant).deliver
    end
    respond_to do |format|
      format.html { redirect_to assistant_roles_path, notice: "Monitores do #{@semester.as_s} notificados com sucesso." }
      format.json { render action: 'index' }
    end
  end

  # POST /assistant_roles/request_for_teaching_assistant_id/1
  def request_evaluations_for_semester
    @semester = Semester.find(params[:semester_id])
    requests = RequestForTeachingAssistant.where(semester: @semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      NotificationMailer.evaluation_request_notification(assistant).deliver
    end
    respond_to do |format|
      format.html { redirect_to assistant_roles_path, notice: "Solicitações enviadas aos professores do #{@semester.as_s} com sucesso." }
      format.json { render action: 'index' }
    end
  end

  def deactivate_assistant_role
    if AssistantRole.exists? params[:id]
      @assistant_role = AssistantRole.find params[:id]
      @assistant_role.deactivate
      respond_to do |format|
        format.html { redirect_to assistant_roles_path }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to assistant_roles_path }
        format.json { head :no_content }
      end
    end
  end    

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def assistant_role_params
    params.permit(
      :student_id, :request_for_teaching_assistant_id
    )
  end

  def separate_by_semester record
    @assistant_roles_by_semester = Semester.all.reverse_order.map do |semester|
      {
        semester: semester,
        role: record.map { |x| x }.keep_if do |role|
          role.request_for_teaching_assistant.semester == semester
        end
      }
    end
  end

  def create_current_months
    @months = [Time.now.month]
    @current_semester_frequencies.each do |freq|
      @months.push(freq.month)
    end
    @months.uniq!
    @months.sort!
  end

  def current_creator
    if secretary_signed_in?
      current_secretary
    elsif user_signed_in?
      current_user.professor
    end
  end
end
