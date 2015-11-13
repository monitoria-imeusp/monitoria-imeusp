class AddEvaluationPeriodToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :evaluation_period, :boolean, default: false, null: false
  end
end
