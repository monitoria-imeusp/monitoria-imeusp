module RequestForTeachingAssistantsHelper
  def priorityOptions
    [
      ['Imprescindível', 0],
      ['Extremamente necessário, mas não imprescindível', 1],
      ['Importante, porém posso abrir mão do auxílio de um monitor', 2]
    ]
  end

  def course_options
    (Course.all.order(:course_code).map do |course|
      [course.course_code + " - " + course.name, course.id]
    end).unshift ["", ""]
  end

  def professor_options
    Professor.all.map do |professor|
      [professor.name, professor.id]
    end
  end
end
