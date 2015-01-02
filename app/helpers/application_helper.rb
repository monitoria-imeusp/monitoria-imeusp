module ApplicationHelper
  def show_yes_or_no(boolean_value)
    boolean_value ? 'Sim' : 'Não'
  end

  def department_options
    (Department.all.map do |department|
      [department.code, department.id]
    end).unshift ["", ""]
  end

  def signed_in?
    admin_signed_in? or secretary_signed_in? or user_signed_in?
  end

  def current_signed
    if admin_signed_in?
      current_admin
    elsif secretary_signed_in?
      current_secretary
    elsif user_signed_in?
      current_user
    end
  end

  def destroy_session_path
    if admin_signed_in?
      destroy_admin_session_path
    elsif secretary_signed_in?
      destroy_secretary_session_path
    elsif user_signed_in?
      destroy_user_session_path
    end
  end
end
