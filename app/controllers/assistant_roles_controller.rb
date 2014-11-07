class AssistantRolesController < ApplicationController
  authorize_resource

  def index
    @assistant_roles_by_semester = Semester.all.reverse_order.map do |semester|
      {
        semester: semester,
        role: AssistantRole.all.map { |x| x }.keep_if do |role|
          role.request_for_teaching_assistant.semester == semester
        end
      }
    end
  end

  def create
    @assistant_role = AssistantRole.new assistant_role_params
    if @assistant_role.save
      respond_to do |format|
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

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def assistant_role_params
    params.permit(
      :student_id, :request_for_teaching_assistant_id
    )
  end
end