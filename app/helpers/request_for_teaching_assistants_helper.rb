module RequestForTeachingAssistantsHelper
  def priorityOptions
    [
      ['Imprescindível', 0],
      ['Extremamente necessário, mas não imprescindível', 1],
      ['Importante, porém posso abrir mão do auxílio de um monitor', 2]
    ]
  end
    
    def show_yes_or_no(boolean_value)
        boolean_value ? 'Sim' : 'Não'
    end

end
