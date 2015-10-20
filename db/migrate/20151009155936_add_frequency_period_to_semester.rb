class AddFrequencyPeriodToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :frequency_period, :integer
  end
end
