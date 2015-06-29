class AddReportInfoToAssistantRole < ActiveRecord::Migration
  def change
    add_column :assistant_roles, :student_amount, :integer
    add_column :assistant_roles, :homework_amount, :integer
    add_column :assistant_roles, :secondary_activity, :string
    add_column :assistant_roles, :workload, :integer
    add_column :assistant_roles, :workload_reason, :string
    add_column :assistant_roles, :comment, :string
    add_column :assistant_roles, :report_creation_date, :datetime
  end
end
