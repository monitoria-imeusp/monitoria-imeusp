class AddCourse4 < ActiveRecord::Migration
  def change
  	add_column :candidatures, :course4_id, :integer
  end
end
