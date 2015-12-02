class AssistantEvaluationsController < ApplicationController
  authorize_resource
  before_action :set_assistant_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /assistant_evaluations/for_student/1
  def index_for_student
    @student = Student.find(params[:student_id])
    student_roles = AssistantRole.where(student: @student)
    @assistant_evaluations = AssistantEvaluation.where(assistant_role_id: student_roles).order(created_at: :desc)
  end

  # GET /assistant_evaluations/1/new
  def new
    @assistant_evaluation = AssistantEvaluation.new
    @assistant_evaluation.assistant_role = AssistantRole.find(params[:assistant_role_id])
    check_evaluation_period
  end

  # GET /assistant_evaluations/1/edit
  def edit
    check_evaluation_period
  end

  # POST /assistant_evaluations
  # POST /assistant_evaluations.json
  def create
    @assistant_evaluation = AssistantEvaluation.new(assistant_evaluation_params)
    check_evaluation_period

    respond_to do |format|
      if @assistant_evaluation.save
        format.html { redirect_to assistant_roles_for_professor_path(current_user.professor), notice: 'Avaliação enviada com sucesso.' }
        format.json { render action: 'index_for_professor', status: :created, location: current_user.professor }
      else
        format.html { render action: 'new' }
        format.json { render json: @assistant_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assistant_evaluations/1
  # PATCH/PUT /assistant_evaluations/1.json
  def update
    check_evaluation_period
    respond_to do |format|
      if @assistant_evaluation.update(assistant_evaluation_params)
        format.html { redirect_to assistant_roles_for_professor_path(current_user.professor), notice: 'Avaliação atualizada com sucesso.' }
        format.json { render action: 'index_for_professor', status: :ok, location: current_user.professor }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assistant_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def check_evaluation_period
      raise CanCan::AccessDenied.new unless @assistant_evaluation.assistant_role.semester.evaluation_period
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_assistant_evaluation
      @assistant_evaluation = AssistantEvaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assistant_evaluation_params
      params.require(:assistant_evaluation).permit(:assistant_role_id, :ease_of_contact, :efficiency, :reliability, :overall, :comment)
    end
end
