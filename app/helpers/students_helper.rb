module StudentsHelper
  
  def show_yes_or_no(boolean_value)
      boolean_value ? 'Sim' : 'Não'
  end

  def yes_or_no
  	[
  		['Sim', 0],
  		['Não', 1]
  	]
  end

  def gender_options
  	[
  		['Feminino', 0],
  		['Masculino', 1]
  	]
  end

end
