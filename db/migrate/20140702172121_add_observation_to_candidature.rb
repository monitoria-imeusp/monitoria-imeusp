class AddObservationToCandidature < ActiveRecord::Migration
  def change
    add_column :candidatures, :observation, :text, default: ""
  end
end
