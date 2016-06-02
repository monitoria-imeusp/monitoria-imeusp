module CandidaturesHelper

  def daytimePreference
    [
      ["Diurno", 0],
      ["Noturno", 1],
      ["Indiferente", 2]
    ]
  end

  def course_options
    Course.all.map do |course|
      [course.course_code + " - " + course.name, course.id]
    end
  end

  def student_options
    (Student.all.map do |student|
      [student.name, student.id]
    end).sort
  end
end
