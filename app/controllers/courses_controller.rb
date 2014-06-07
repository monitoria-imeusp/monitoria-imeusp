class CoursesController < ApplicationController
  before_action :authenticate! , :except => [:show, :index]

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
    else
      redirect_to courses_path
    end
  end

  def index
    @courses = Course.all
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

  protected 

  def authenticate!
    unless admin_signed_in? or (professor_signed_in? and current_professor.super_professor?)
      redirect_to courses_path
    end
  end

  private
  def complete_course_code
    course = params.require(:course)
    department_code = Department.find_by(:id => course[:department_id]).code
    unless course[:course_code].starts_with?(department_code)
      course[:course_code] = department_code + course[:course_code]
    end
  end

  def course_params
    complete_course_code
    params.require(:course).permit(:name, :course_code, :department_id)
  end
end
