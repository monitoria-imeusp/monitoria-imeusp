class CreateCandidatures < ActiveRecord::Migration
  def change
    create_table :candidatures do |t|
      t.boolean :avaliability_daytime
      t.boolean :avaliability_night_time
      t.string :time_period_preference
      t.integer :course1_id
      t.integer :course2_id
      t.integer :course3_id

      t.timestamps
    end
  end
end
