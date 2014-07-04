class AddTranscriptFile < ActiveRecord::Migration
  def change
      add_column :candidatures, :transcript_file_path, :string
  end
end
