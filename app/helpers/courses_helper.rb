module CoursesHelper
  def department_options
    (Department.all.map do |department|
        [department.code, department.id]
    end).unshift ["", ""]
  end
end
