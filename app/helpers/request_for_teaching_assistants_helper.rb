module RequestForTeachingAssistantsHelper
  def priorityOptions
    [
      ['Imprescindível', 0],
      ['Extremamente necessário, mas não imprescindível', 1],
      ['Importante, porém posso abrir mão do auxílio de um monitor', 2]
    ]
  end

  def course_options
    Course.all.order(:course_code).map do |course|
      [course.course_code + " - " + course.name, course.id]
    end
  end

  def professor_options
    (Professor.all.map do |professor|
      [professor.name, professor.id]
    end).sort
  end
  
  def candidatures_table candidates, title
    table = "<table class=\"table table-hover\">
    <thead>
      <tr>
        <th>Nome</th>
        <th>Nº USP</th>
        <th>Já foi eleito?</th>
        <th colspan=\"2\"></th>
      </tr>
    </thead>

    <tbody> "
    if !title.nil? and !title.empty?
        table += "<h3>" + title + "</h3>"
    end
    candidates.each do |candidature|
        if candidature.elected?
            table += "<tr class=\"elected\">"
        else
            table += "<tr>"
        end
        table += "<td>" + candidature.student.name + "</td>"
        table += "<td>" + candidature.student.nusp.to_s + "</td>"
        table += "<td>" + show_yes_or_no(candidature.elected?) + "</td>"
        table += "<td>" + link_to('Detalhes', candidature) + "</td>" 
        if candidature.elected?
            table += "<td>" + link_to('Eleger', create_assistant_role_path(@request_for_teaching_assistant, candidature.student), 
            method: :post, data: {confirm: "Este estudante já foi eleito para monitor(a) de outra disciplina, está certo que deseja elegê-lo(a) novamente?"}) + "</td>"
        else
            table += "<td>" + link_to('Eleger', create_assistant_role_path(@request_for_teaching_assistant, candidature.student), method: :post) + "</td>"
        end
        table += "</tr>"
    end
    table += "</tbody> </table>"
    table.html_safe
  end
end
