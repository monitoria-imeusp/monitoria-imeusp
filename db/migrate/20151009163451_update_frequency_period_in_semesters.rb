class UpdateFrequencyPeriodInSemesters < ActiveRecord::Migration
  def change
    Semester.all.each do |semester|
      semester.update(frequency_period: 0)
    end
  end
end
