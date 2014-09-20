class AddSemesterToCandidature < ActiveRecord::Migration
  def up
    change_table :candidatures do |t|
      t.belongs_to :semester
    end
    Candidature.all.each do |candidature|
      candidature.semester_id = Semester.first.id
      candidature.save
    end
  end
  def down
    change_table :candidatures do |t|
      t.remove :semester_id
    end
  end
end
