class AddActiveToSemester < ActiveRecord::Migration
  def up
    add_column :semesters, :active, :boolean
    Semester.all.each do |semester|
      semester.active = semester.open
      semester.save
    end
  end
  def down
    change_table :semester do |t|
      t.remove :active
    end
  end
end
