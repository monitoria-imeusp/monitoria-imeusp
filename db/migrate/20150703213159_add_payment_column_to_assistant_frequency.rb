class AddPaymentColumnToAssistantFrequency < ActiveRecord::Migration
  def change
    add_column :assistant_frequencies, :payment, :boolean
  end
end
