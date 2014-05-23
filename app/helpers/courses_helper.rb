module CoursesHelper
  def department_options
    (Department.all.map do |department|
        [department.code, department.id]
    end).unshift ["SELECIONE", ""]
  end
end
