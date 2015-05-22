class AddVoluntaryColumnToCandidature < ActiveRecord::Migration
  def change
    add_column :candidatures, :voluntary, :boolean
    change_column_default :candidatures, :voluntary, false
  end
end
