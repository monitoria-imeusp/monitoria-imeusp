class ChangeAdvisesMessageColumnToLongtext < ActiveRecord::Migration
  def change
    change_column :advises, :message, :text, :limit => 1048576
  end
end
