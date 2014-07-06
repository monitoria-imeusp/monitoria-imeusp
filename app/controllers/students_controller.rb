class StudentsController < ApplicationController
  authorize_resource

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      sign_in  @student, :bypass => true
      redirect_to @student
    else
      render 'new'
    end
  end

  def show
    if Student.exists?(params[:id])
      @student = Student.find(params[:id])
      authorization_student
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
      authorization_student
    end
  end

  def update
    @student = Student.find(params[:id])
    authorization_student
    if params[:student][:password].blank? && params[:student][:password_confirmation].blank?
      params[:student].delete(:password)
      params[:student].delete(:password_confirmation)
    end
    if @student.update(student_params)
      sign_in  @student, :bypass => true
      redirect_to @student
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    authorization_student
    @student.destroy

    redirect_to students_path
  end

  private
  def authorization_student
    if student_signed_in? and @student.id != current_student.id
      raise CanCan::AccessDenied.new()
    end
  end

  def student_params
    params.require(:student).permit(:name, :password, :password_confirmation,
                                    :nusp, :gender, :rg, :cpf, 
                                    :address, :complement, :district, :zipcode, :city, :state, 
                                    :tel, :cel, :email, 
                                    :has_bank_account)
  end
end
