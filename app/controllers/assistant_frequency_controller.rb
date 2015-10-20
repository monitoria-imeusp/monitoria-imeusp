class AssistantFrequencyController < ApplicationController

  authorize_resource

  def monthly_control
    @semester = Semester.find params[:semester_id]
    @month = params[:month].to_i
    @filter = params[:filter].to_i
    if current_hiper_professor? or secretary_signed_in?
      if params[:department_id].present?
        @department = Department.find params[:department_id]
        @assistant_roles = AssistantRole.for_department_and_semester @department, @semester
      else
        @assistant_roles = AssistantRole.for_semester @semester
      end
      if @filter != AssistantFrequency.FILTER_ALL
        @assistant_roles = @assistant_roles.map { |x| x }.keep_if do |role|
          (role.frequency_status_for_month @month) == AssistantFrequency.FILTERS[@filter]
        end
      end
    else
      @assistant_roles = AssistantRole.for_semester @semester
      @assistant_roles = @assistant_roles.map { |x| x }.keep_if do |role|
        @current_user.should_see_role role
      end
    end
  end

  def open_frequency_period
    @semester = Semester.find params[:semester_id]
    @month = params[:month].to_i
    @semester.open_frequency_period(Semester.month_to_period @month)
    redirect_to assistant_frequency_monthly_control_path(@semester, @month)
  end

  def close_frequency_period
    @semester = Semester.find params[:semester_id]
    @month = params[:month].to_i
    @semester.close_frequency_period(Semester.month_to_period @month)
    redirect_to assistant_frequency_monthly_control_path(@semester, @month)
  end
 
  def mark_assistant_role_frequency
    presence = params[:presence]
    month = params[:month]
    role = params[:role]
    id = params[:pid]
    @assistant_frequency = AssistantFrequency.new(month: month, presence: presence, assistant_role_id: role, payment: false)
    if @assistant_frequency.save
      if presence
        respond_to do |format|
          format.html { redirect_to assistant_roles_for_professor_path(id), notice: 'Presença marcada com sucesso.' }      
        end
      else 
        respond_to do |format|
          format.html { redirect_to assistant_roles_for_professor_path(id), notice: 'Ausência marcada com sucesso.' }      
        end
      end
    else
        respond_to do |format|
          format.html { redirect_to assistant_roles_for_professor_path(id), notice: 'Erro ao marcar frequência.' }      
        end      
    end
  end

  def mark_generic_assistant_role_frequency
    presence = params[:presence]
    month = params[:month]
    role = params[:role]
    id = params[:pid]
    @assistant_frequency = AssistantFrequency.new(month: month, presence: presence, assistant_role_id: role, payment: false)
    if @assistant_frequency.save
      if presence
        respond_to do |format|
          format.html { redirect_to assistant_frequency_monthly_control_path(@assistant_frequency.semester, month, AssistantFrequency.FILTER_ALL), notice: 'Presença marcada com sucesso.' }      
        end
      else 
        respond_to do |format|
          format.html { redirect_to assistant_frequency_monthly_control_path(@assistant_frequency.semester, month, AssistantFrequency.FILTER_ALL), notice: 'Ausência marcada com sucesso.' }      
        end
      end
    else
        respond_to do |format|
          format.html { redirect_to assistant_frequency_monthly_control_path(@assistant_frequency.semester, month, AssistantFrequency.FILTER_ALL), notice: 'Erro ao marcar frequência.' }      
        end
    end
  end

  def pay_all_assistants
    semester = Semester.find params[:semester_id]
    month = params[:month]
    AssistantFrequency.for_semester_and_month(semester, month).each do |freq|
      freq.pay_if_present
    end
    redirect_to assistant_frequency_monthly_control_path(semester, month, AssistantFrequency.FILTER_ALL)
  end

end
