class CoursesController < ApplicationController
    before_action :authenticate_professor!, :except => [:show, :index]
    before_action do
        redirect_to :new_professor_session_path unless current_professor.super_professor?
    end

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

    private
        def course_params
            params.require(:course).permit(:name, :course_code)
        end
end
