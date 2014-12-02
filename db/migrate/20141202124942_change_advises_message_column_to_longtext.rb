class ChangeAdvisesMessageColumnToLongtext < ActiveRecord::Migration
  def change
    change_column :advises, :message, :longtext
  end
end
