class ChangeCandidatureColumns < ActiveRecord::Migration
  def change
  	rename_column :candidatures, :avaliability_daytime, :daytime_availability
  	rename_column :candidatures, :avaliability_night_time, :night_availability
  end
end
