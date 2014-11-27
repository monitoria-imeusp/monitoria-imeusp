module AssistantEvaluationsHelper
  def evaluation_grades
    [
      ['Ótimo', 0],
      ['Bom', 1],
      ['Regular', 2]
    ]
  end

  def criteria
    [
      :ease_of_contact,
      :efficiency,
      :reliability,
      :overall
    ]
  end
end
