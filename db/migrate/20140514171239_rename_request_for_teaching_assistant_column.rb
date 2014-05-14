class RenameRequestForTeachingAssistantColumn < ActiveRecord::Migration
  def change
    rename_column :request_for_teaching_assistants, :requestedNumber, :requested_number
  end
end
