class StudentsController < ApplicationController
  authorize_resource

  def new
    authorization_user
    @student = Student.new
  end

  def create
    authorization_user
    @student = Student.new(student_params)

    if @student.valid?
      @student.user_id = current_user.id

      if (params[:student][:institute] == "Outro") and params[:student][:institute_text].empty?
        @student.errors.add(:student_id, t('errors.models.student.toofew'))
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      elsif @student.save
        redirect_to current_user
      else
        render 'new'
      end
    else
      respond_to do |format|
        format.html { render action: 'new'}
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @students = Student.all
  end

  def edit
    if Student.exists?(params[:id])
      @student = Student.find(params[:id])
      @user = @student.user
      authorization_student
    end
  end

  def update
    @student = Student.find(params[:id])
    authorization_student
    if (params[:student][:institute] == "Outros") and params[:student][:institute_text].empty?
        @student.errors.add(:student_id, t('errors.models.student.toofew'))
        respond_to do |format|
          format.html { render action: 'edit' }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
    elsif @student.update(student_params)
      respond_to do |format|
        format.html { redirect_to @student.user, notice: 'Dados de aluno atualizados com sucesso.' }
        format.json { render action: 'show', status: :created, location: @student.user }
      end
    else
      render 'edit'
    end
  end

  private
  def authorization_user
    raise CanCan::AccessDenied.new if current_user.student?
  end


  def authorization_student
    if current_student? and @student.user.id != current_user.id
      raise CanCan::AccessDenied.new()
    end
  end

  def student_params
    params.require(:student).permit(:name, :password, :password_confirmation,
                                    :nusp, :institute, :institute_text, :gender, :rg, :cpf,
                                    :address, :complement, :district, :zipcode, :city, :state,
                                    :tel, :cel, :email,
                                    :has_bank_account)
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation,
                                 :nusp, :email)
  end
end
