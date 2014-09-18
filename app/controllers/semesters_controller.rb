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

  def update
    @semester = Semester.find params[:id]
    if @semester.update semester_params
      redirect_to semesters_path
    else
      render :edit
    end
  end

  private

  def ordered_semesters
    Semester.order :year, :parity
  end

  def semester_params
    permitted = params.require(:semester).permit(:year, :parity, :open)
  end

end