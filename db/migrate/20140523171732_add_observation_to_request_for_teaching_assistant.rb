class AddObservationToRequestForTeachingAssistant < ActiveRecord::Migration
  def change
    add_column :request_for_teaching_assistants, :observation, :text, default: ""
  end
end
