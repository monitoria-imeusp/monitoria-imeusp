class FixCandidatureColumns < ActiveRecord::Migration
  def change
  	rename_column :candidatures, :night_availability, :nighttime_availability
  end
end
