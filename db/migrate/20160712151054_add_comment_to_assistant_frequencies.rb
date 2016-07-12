class AddCommentToAssistantFrequencies < ActiveRecord::Migration
  def change
    add_column :assistant_frequencies, :comment, :text
  end
end
