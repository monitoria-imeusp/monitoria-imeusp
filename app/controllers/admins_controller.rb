class AdminsController < ApplicationController
	before_action :authenticate_admin!

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

  def register_courses
    @admin = Admin.new
    @admin.registered_courses = false
    Course.destroy_all
    if (@admin.gather_undergrad_courses) and (@admin.gather_postgrad_courses)
      @admin.registered_courses = true
    end
  end

  private
    def admin_params
   		params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end