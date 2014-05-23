class LinkingDepartment < ActiveRecord::Migration
  def change
      change_table :courses do | t |
          t.belongs_to :department
      end
  end
end
