class SemestersController < ApplicationController
  authorize_resource

  def create
    last = ordered_semesters.last
    if last == nil
      @semester = Semester.new year: Time.now.year, parity: 0, open: false, active: false
    elsif last.parity == 0
      @semester = Semester.new year: last.year, parity: 1, open: false, active: false
    else
      @semester = Semester.new year: last.year+1, parity: 0, open: false, active: false
    end
    if @semester.save
      respond_to do |format|
        format.html { redirect_to semesters_path, notice: 'Semestre criado com sucesso.' }
        format.json { render action: 'index', status: :created, location: @semester }
      end
    else
      respond_to do |format|
        format.html { redirect_to semesters_path }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @semesters = ordered_semesters
  end

  def open
    change_state true, true
  end

  def activate
    @semester = Semester.find params[:id]
    AssistantFrequency.schedule_notifications 1
    change_state false, true
  end

  def close
    change_state false, true
  end

  def deactivate
    change_state false, false
  end

  def open_evaluation_period
    semester = Semester.find params[:id]
    semester.open_evaluation_period
    redirect_to semesters_path
  end

  def close_evaluation_period
    semester = Semester.find params[:id]
    semester.close_evaluation_period
    redirect_to semesters_path
  end

  private

  def change_state state_open, state_active
    @semester = Semester.find params[:id]
    @semester.open = state_open
    @semester.active = state_active
    if @semester.save
      redirect_to semesters_path
    else
      render semesters_path
    end
  end

  def ordered_semesters
    Semester.order :year, :parity
  end

  def semester_params
    permitted = params.require(:semester).permit(:year, :parity, :open, :active)
  end

end