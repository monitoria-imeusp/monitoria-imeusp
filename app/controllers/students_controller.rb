class StudentsController < ApplicationController
    before_action :authenticate!,  :only => [:index]


    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            redirect_to @student
        else
            render 'new'
        end
    end

    def show
        if Student.exists?(params[:id])
            @student = Student.find(params[:id])
        else
            redirect_to students_path
        end
    end

    def index
        @students = Student.all
    end

    def edit
        if Student.exists?(params[:id])
            @student = Student.find(params[:id])
        else
            redirect_to students_path
        end
    end

    def update
        if not Student.exists? params[:id]
            # TODO alert failure
            redirect_to student_path
            return
        end
        @student = Student.find(params[:id])
        if @student.update(student_params)
            redirect_to @student
        else
            render 'edit'
        end
    end

    def destroy
        @student = Student.find(params[:id])
        @student.destroy

        redirect_to students_path
    end

    protected 

    def authenticate!
        unless admin_signed_in? or professor_signed_in?
            redirect_to students_path
        end
    end

    private
        def student_params
            params.require(:student).permit(:name, :password, :nusp, :gender, :rg, :cpf, :adress, :complement, :district, :zipcode, :city, :state, :tel, :cel, :email, :has_bank_account)
        end
end
