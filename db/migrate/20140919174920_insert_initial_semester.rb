class InsertInitialSemester < ActiveRecord::Migration
  def change
    Semester.create(year: 2014, parity: 1, open: false)
  end
end
