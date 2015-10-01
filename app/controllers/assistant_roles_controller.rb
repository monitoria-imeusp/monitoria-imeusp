class AssistantRolesController < ApplicationController
  authorize_resource

  # GET /assistant_roles
  def index
    get_semester
    @assistant_roles = AssistantRole.for_semester @semester
    unless should_see_all_roles?
      @assistant_roles = @assistant_roles.map { |x| x }.keep_if do |role|
        should_see_the_role role
      end
    end
    create_current_months @assistant_roles
  end

  # GET /assistant_roles/for_professor/1
  def index_for_professor
    get_semester
    @professor = Professor.find(params[:professor_id])
    raise CanCan::AccessDenied.new unless current_user.professor == @professor
    @assistant_roles = AssistantRole.for_professor_and_semester @professor, @semester
    create_current_months AssistantRole.for_semester @semester
  end

  def create
    @assistant_role = AssistantRole.new assistant_role_params
    student_exists = Student.exists? @assistant_role.student_id
    request_exists = RequestForTeachingAssistant.exists? @assistant_role.request_for_teaching_assistant_id
    if student_exists and request_exists and @assistant_role.save
      respond_to do |format|
        BackupMailer.new_assistant_role(@assistant_role, current_creator).deliver
        format.html { redirect_to @assistant_role.request_for_teaching_assistant, notice: 'Monitor eleito com sucesso.' }
        format.json { render action: 'show', status: :created, location: @assistant_role.request_for_teaching_assistant }
      end
    elsif request_exists
      respond_to do |format|
        format.html { redirect_to @assistant_role.request_for_teaching_assistant, notice: 'Erro ao criar monitor.' }
        format.json { render json: @assistant_role.errors, status: :unprocessable_entity }
      end  
    else
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Erro ao criar monitor.' }
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

  def update
    @assistant_role = AssistantRole.find params[:id]
    @assistant_role.student_amount = params[:assistant_role][:student_amount]
    @assistant_role.homework_amount = params[:assistant_role][:homework_amount]
    @assistant_role.secondary_activity = params[:assistant_role][:secondary_activity]
    @assistant_role.workload = params[:assistant_role][:workload]
    @assistant_role.workload_reason = params[:assistant_role][:workload_reason]
    @assistant_role.comment = params[:assistant_role][:comment]
    @assistant_role.report_creation_date = params[:assistant_role][:report_creation_date]
    @assistant_role.save
    redirect_to candidatures_path
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
    professors = []
    requests = RequestForTeachingAssistant.where(semester: @semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      professors.push(assistant.professor)
    end
    professors.uniq.each do |professor|
        NotificationMailer.evaluation_request_notification(professor, @semester).deliver
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

  def certificate
    if AssistantRole.exists? params[:id]
      @assistant = AssistantRole.find params[:id]
      if @assistant.student.is_female?
        @genderfied_title = "aluna-monitora"
      else
        @genderfied_title = "aluno-monitor"
      end      
      render pdf: "Certificado #{@assistant.student.name}"
    else 
      respond_to do |format|
        format.html { redirect_to assistant_roles_path, notice: "Erro ao gerar atestado."}
        format.json { render action: 'index'}
      end
    end
  end

  def report_form
    @role = AssistantRole.find params[:id]
  end

  def print_report
    if AssistantRole.exists? params[:id]
      @assistant = AssistantRole.find params[:id]
      render pdf: "Relatório #{@assistant.student.name}"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def assistant_role_params
    params.permit(
      :student_id, :request_for_teaching_assistant_id
    )
  end

  def get_semester
    if params[:semester_id].present?
      @semester = Semester.find params[:semester_id]
    else
      @semester = Semester.current
    end
  end

  def should_see_all_roles?
    current_hiper_professor? or secretary_signed_in?
  end

  def should_see_the_role role
    (current_super_professor? and role.course.dep_code == current_user.professor.dep_code) \
    or \
    (current_professor? and role.request_for_teaching_assistant.professor == current_user.professor)
  end

  def separate_by_semester record
    @assistant_roles_by_semester = Semester.all.reverse_order.map do |semester|
      {
        semester: semester,
        role: record.map { |x| x }.keep_if do |role|
          ((role.request_for_teaching_assistant.semester == semester) and 
            (should_see_all_roles? or should_see_the_role(role)))
        end
      }
    end
    @assistant_roles_by_semester.each do |entry|
      entry[:role].sort! { |a, b| a.student.name <=> b.student.name }
    end
  end

  
  def create_current_months roles
    @months = [Time.now.month]
    if @current_semester_frequencies
      @current_semester_frequencies.each do |freq|
        @months.push(freq.month)
      end
    else
      roles.each do |role|
        role.assistant_frequency.each do |freq|
          @months.push(freq.month)
        end
      end
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
