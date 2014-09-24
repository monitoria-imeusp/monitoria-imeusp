module StudentsHelper

  def yesOrNo
    [
      ['Sim', true],
      ['Não', false]
    ]
  end

  def genderOptions
    [
      ['Feminino', 0],
      ['Masculino', 1]
    ]
  end

  def institute_options
    [
      "Instituto de Matemática e Estatística",
      "Instituto de Física",
      "Escola Politécnica"
    ]
  end

end
