class AssistantFrequencyController < ApplicationController
  def create
    @assistant_frequency = AssistantFrequency.new assistant_frequency_params
    if @assistant_frequency.save
      respond_to do |format|
        format.html { redirect_to @assistant_frequency.assistant_role.index, notice: 'Frequência marcada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @assistant_frequency.assistant_role }
      end
    else
      respond_to do |format|
        format.html { redirect_to @assistant_frequency.assistant_role }
        format.json { render json: @assistante_frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  def request_frequency
    professors = []
    semester = Semester.current
    requests = RequestForTeachingAssistant.where(semester: semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      professors.push(assistant.professor)
    end
    professors.uniq.each do |professor|   
      NotificationMailer.frequency_request_notification(professor).deliver      
    end
    respond_to do |format|
      format.html { redirect_to '/assistant_roles', notice: 'Pedidos enviados com sucesso.' }      
    end
  end

end
