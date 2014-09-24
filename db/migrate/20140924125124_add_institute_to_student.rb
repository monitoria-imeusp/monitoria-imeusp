class AddInstituteToStudent < ActiveRecord::Migration
  def up
    add_column :students, :institute, :string
    Student.all.each do |student|
      student.institute = "Instituto de Matemática e Estatística"
      student.save
    end
  end
  def down
    change_table :students do |t|
      t.remove :institute
    end
  end
end
