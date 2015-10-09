class ChangeFrequencyPeriodDefault < ActiveRecord::Migration
  def change
    change_column_default :semesters, :frequency_period, 0
  end
end
