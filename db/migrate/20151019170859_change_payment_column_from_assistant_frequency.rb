class ChangePaymentColumnFromAssistantFrequency < ActiveRecord::Migration
  def change
    change_column_default :assistant_frequencies, :payment, false
    AssistantFrequency.all.each do |freq| 
      if freq.payment == nil
        freq.update_column(:payment, false)
      end
    end
    change_column_null :assistant_frequencies, :payment, false
  end
end
