class AssistantEvaluationsController < ApplicationController
  authorize_resource
  before_action :set_assistant_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /assistant_evaluations/for_student/1
  def index_for_student
    @assistant_evaluations = AssistantEvaluation.all
  end

  # GET /assistant_evaluations/new
  def new
    @assistant_evaluation = AssistantEvaluation.new
  end

  # GET /assistant_evaluations/1/edit
  def edit
  end

  # POST /assistant_evaluations
  # POST /assistant_evaluations.json
  def create
    @assistant_evaluation = AssistantEvaluation.new(assistant_evaluation_params)

    respond_to do |format|
      if @assistant_evaluation.save
        format.html { redirect_to @assistant_evaluation, notice: 'Assistant evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assistant_evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @assistant_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assistant_evaluations/1
  # PATCH/PUT /assistant_evaluations/1.json
  def update
    respond_to do |format|
      if @assistant_evaluation.update(assistant_evaluation_params)
        format.html { redirect_to @assistant_evaluation, notice: 'Assistant evaluation was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @assistant_evaluation }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assistant_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistant_evaluations/1
  # DELETE /assistant_evaluations/1.json
  def destroy
    @assistant_evaluation.destroy
    respond_to do |format|
      format.html { redirect_to assistant_evaluations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assistant_evaluation
      @assistant_evaluation = AssistantEvaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assistant_evaluation_params
      params.require(:assistant_evaluation).permit(:assistant_role_id, :ease_of_contact, :efficiency, :reliability, :overall, :comment)
    end
end
