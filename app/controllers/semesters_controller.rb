class SemestersController < ApplicationController
  authorize_resource

  def create
    last = ordered_semesters.last
    if last.parity == 0
      @semester = Semester.new year: last.year, parity: 1, open: false
    else
      @semester = Semester.new year: last.year+1, parity: 0, open: false
    end
    if @semester.save
      redirect_to semesters_path
    else
      render :new
    end
  end

  def index
    @semesters = ordered_semesters
  end

  def open
    change_state true
  end

  def close
    change_state false
  end

  private

  def change_state state
    @semester = Semester.find params[:id]
    @semester.open = state
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
    permitted = params.require(:semester).permit(:year, :parity, :open)
  end

end