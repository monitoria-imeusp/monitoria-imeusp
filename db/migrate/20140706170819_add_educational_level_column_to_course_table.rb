class AddEducationalLevelColumnToCourseTable < ActiveRecord::Migration
  def change
    add_column :courses, :educational_level, :integer, default: 0
  end
end
