class CoursesController < ApplicationController
  authorize_resource

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def show
    if Course.exists?(params[:id])
      @course = Course.find(params[:id])
      @first_option_candidature = Candidature.where("course1_id = ?", @course.id)
      @first_option_candidature = @first_option_candidature.select{|t| t.semester.open}

      @second_option_candidature = Candidature.where("course2_id = ?", @course.id)
      @second_option_candidature = @second_option_candidature.select{|t| t.semester.open}

      @third_option_candidature = Candidature.where("course3_id = ?", @course.id)
      @third_option_candidature = @third_option_candidature.select{|t| t.semester.open}

      @fourth_option_candidature = Candidature.where("course4_id = ?", @course.id)
      @fourth_option_candidature = @fourth_option_candidature.select{|t| t.semester.open}
    else
      redirect_to courses_path
    end
  end

  def index
    @courses = Course.all.order(:course_code)
  end

  def edit
    if Course.exists?(params[:id])
      @course = Course.find(params[:id])
      @course.course_code.sub!(Department.find_by(:id => @course.department_id).code, "")
    else
      redirect_to courses_path
    end
  end

  def update
    if not Course.exists? params[:id]
      # TODO alert failure
      redirect_to course_path
      return
    end
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :course_code, :department_id)
  end
end
