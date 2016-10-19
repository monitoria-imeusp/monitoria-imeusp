class AssistantRolesController < ApplicationController
  authorize_resource

  # GET /assistant_roles
  def index
    get_semester
    get_department
    if should_see_all_roles?
      if params[:department_id].present?
        @assistant_roles = AssistantRole.for_department_and_semester @department, @semester
      else
        @assistant_roles = AssistantRole.for_semester @semester
      end
        p @assistant_roles
    else
      @assistant_roles = AssistantRole.for_semester @semester
      @assistant_roles = @assistant_roles.map { |x| x }.keep_if do |role|
        should_see_the_role role
      end
    end
  end

  # GET /assistant_roles/for_professor/1
  def index_for_professor
    get_semester
    @professor = Professor.find(params[:professor_id])
    raise CanCan::AccessDenied.new unless current_user.professor == @professor
    @assistant_roles = AssistantRole.for_professor_and_semester @professor, @semester
  end

  # GET /assistant_roles/new
  def new
    @request = RequestForTeachingAssistant.find(assistant_role_params[:request_for_teaching_assistant_id])
    if @request.incomplete?
      @first_option_candidatures = sort_candidates(Candidature.all_first_options_for_request @request)
      @nonfirst_option_candidatures = sort_candidates(Candidature.all_nonfirst_options_for_request @request)
      @same_department_candidatures = sort_candidates(Candidature.all_for_same_department_request @request)
      if search_params[:nusp].present?
        @other_candidatures = sort_candidates(Candidature.for_nusp_and_semester search_params[:nusp], @request.semester)
      else
        @other_candidatures = []
      end
    else
      redirect_to @request
    end
  rescue ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new('Not Found')
  end

  def create
    @assistant_role = AssistantRole.new assistant_role_params
    student_exists = Student.exists? @assistant_role.student_id
    request_exists = RequestForTeachingAssistant.exists? @assistant_role.request_for_teaching_assistant_id
    if student_exists and request_exists
      @assistant_role.started_at = [Time.now, @assistant_role.standard_first_day].max
      if @assistant_role.save
        respond_to do |format|
          BackupMailer.new_assistant_role(@assistant_role, current_creator).deliver
          format.html { redirect_to @assistant_role.request_for_teaching_assistant, notice: 'Monitor eleito com sucesso.' }
          format.json { render action: 'show', status: :created, location: @assistant_role.request_for_teaching_assistant }
        end
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
    AssistantEvaluation.request_evaluations_for_semester @semester
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

  def reactivate_assistant_role
    if AssistantRole.exists? params[:id]
      @assistant_role = AssistantRole.find params[:id]
      @assistant_role.reactivate
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
    check_evaluation_period @role
  end

  def print_report
    if AssistantRole.exists? params[:id]
      @assistant = AssistantRole.find params[:id]
      render pdf: "Relatório #{@assistant.student.name}"
    end
  end

  private

  def sort_candidates candidates
    candidates.map{ |x| x }.sort! { |a, b| a.student.name <=> b.student.name }
  end

  def check_evaluation_period role
    raise CanCan::AccessDenied.new unless role.semester.evaluation_period
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assistant_role_params
    params.permit(
      :student_id, :request_for_teaching_assistant_id
    )
  end

  def search_params
    params.permit(:nusp)
  end

  def get_semester
    if params[:semester_id].present?
      @semester = Semester.find params[:semester_id]
    else
      @semester = Semester.last_active_but_closed
      if @semester.nil?
        @semester = Semester.last
      end
    end
  end

  def get_department
    if params[:department_id].present?
      @department = Department.find params[:department_id]
    else
      @department = nil
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
