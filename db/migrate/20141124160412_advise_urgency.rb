class AdviseUrgency < ActiveRecord::Migration
  def change
  	add_column :advises, :advise_urgency, :boolean
  end
end
