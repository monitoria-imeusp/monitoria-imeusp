module RequestForTeachingAssistantsHelper
  def priorityOptions
    [
      ['Imprescindível', 0],
      ['Extremamente necessário, mas não imprescindível', 1],
      ['Importante, porém posso abrir mão do auxílio de um monitor', 2]
    ]
  end  

  def course_options
    (Course.all.map do |course|
      [course.name, course.id]
    end).unshift ["", ""]
  end
end
