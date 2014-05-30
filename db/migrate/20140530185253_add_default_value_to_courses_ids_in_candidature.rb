class AddDefaultValueToCoursesIDsInCandidature < ActiveRecord::Migration
  def up
    change_column_default :candidatures, :course1_id, 0
    change_column_default :candidatures, :course2_id, 0
    change_column_default :candidatures, :course3_id, 0
  end

  def down
    change_column_default :candidatures, :course1_id, nil
    change_column_default :candidatures, :course2_id, nil
    change_column_default :candidatures, :course3_id, nil
  end
end
