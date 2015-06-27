class AssistantFrequencyController < ApplicationController

  authorize_resource
 
  def mark_assistant_role_frequency
    presence = params[:presence]
    month = params[:month]
    role = params[:role]
    id = params[:pid]
    red_path = '/assistant_roles/for_professor/'+id
    if params[:redirect_to_index] == "not_for_professor"
      red_path = '/assistant_roles'
    end
    @assistant_frequency = AssistantFrequency.new(month: month, presence: presence, assistant_role_id: role)
    if @assistant_frequency.save
      if presence
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Presença marcada com sucesso.' }      
        end
      else 
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Ausência marcada com sucesso.' }      
        end
      end
    else
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Erro ao marcar frequência.' }      
        end      
    end
  end
end
