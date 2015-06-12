class AdminsController < ApplicationController
  authorize_resource

  def show
    if Admin.exists?(params[:id])
      @admin = Admin.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def edit
    if Admin.exists?(params[:id])
      @admin = Admin.find(params[:id])
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end
    if @admin.update(admin_params)
      sign_in  @admin, :bypass => true
      redirect_to @admin
    else
      render 'edit'
    end
  end

  def control_panel
    puts 'hey'
  end

  def register_undergraduate_courses
    respond_to do |format|
      if Course.gather_undergraduate_courses
        format.html { redirect_to control_panel_admins_path, notice: 'Disciplinas cadastradas com sucesso.' }
      else
        format.html { redirect_to control_panel_admins_path, alert: 'Houve algum problema no cadastro das disciplinas.' }
      end
    end
  end

  def register_postgraduate_courses
    respond_to do |format|
      if Course.gather_postgraduate_courses
        format.html{ redirect_to control_panel_admins_path, notice: 'Disciplinas cadastradas com sucesso.' }
      else
        format.html{ redirect_to control_panel_admins_path, alert: 'Houve algum problema no cadastro das disciplinas.' }
      end
    end
  end

  def duplicate_students
    @duplicates = []
    Student.all.each do |student|
      entry = []
      Student.all.each do |other|
        if student.id < other.id and student.nusp == other.nusp then
          entry.push student if entry.empty?
          entry.push other
        end
      end
      @duplicates.push entry unless entry.empty?
    end
    respond_to do |format|
      if @duplicates.empty?
        format.html { render control_panel_admins_path, notice: 'Nenhum aluno duplicado.' }
      else
        format.html { render control_panel_admins_path, alert: 'Alunos duplicados foram encontrados.' }
      end
    end
  end

  private
    def admin_params
   		params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end
