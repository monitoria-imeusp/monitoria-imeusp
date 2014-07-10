class RemoveTranscriptFilePathFromCandidature < ActiveRecord::Migration
  def change
    remove_column :candidatures, :transcript_file_path, :string
  end
end
