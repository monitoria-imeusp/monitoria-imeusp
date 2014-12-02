class ChangeAdvisesMessageColumnToLongtext < ActiveRecord::Migration
  def change
    change_column :advises, :message, :text, :limit => 4294967295
  end
end
