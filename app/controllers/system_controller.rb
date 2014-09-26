class SystemController < ApplicationController
  before_action :authorize

  def candidature_index
    @semesters = Semester.all
    @departments = Department.all
  end

  def candidature_index_for_department

  end

  private

  def authorize
    unless admin_signed_in? or secretary_signed_in?
      raise CanCan::AccessDenied.new()
    end
  end

end
