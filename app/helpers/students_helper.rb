module StudentsHelper

  def show_yes_or_no(boolean_value)
    boolean_value ? 'Sim' : 'Não'
  end

  def yesOrNo
    [
      ['Sim', 0],
      ['Não', 1]
    ]
  end

  def genderOptions
    [
      ['Feminino', 0],
      ['Masculino', 1]
    ]
  end

end
