class AddStartedAtAndFinishedAtColumnstoAssistantRoles < ActiveRecord::Migration
  def change
    add_column :assistant_roles, :started_at, :datetime
    add_column :assistant_roles, :finished_at, :datetime
    AssistantRole.all.each do |role|
      semester = role.semester
      role.update(started_at: DateTime.new(semester.year, semester.months[0], 1))
    end
  end
end
