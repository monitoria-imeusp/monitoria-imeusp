require 'spec_helper'

RSpec::Matchers.define :is_time do |t1| 
	match { |t2| t1.to_s == t2.to_s }
end

describe AssistantFrequency do
  let(:now) { DateTime.new(2016, 4, 20, 1, 0, 0) }
  let(:frequency_mail_params) {{ priority: 0, run_at: DateTime.new(2016, 5, 20, 0, 0, -3).getutc }}
  let(:remainder_mail_params) {{ priority: 0, run_at: DateTime.new(2016, 5, 26, 0, 0, -3).getutc }}
  let!(:semester) { FactoryGirl.create :semester, parity: 0 }
  let!(:department) { FactoryGirl.create :department }
  let!(:user) { FactoryGirl.create :user }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:prof_user) { FactoryGirl.create :another_user }
  let!(:professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let!(:course1) { FactoryGirl.create :course1 }
  let!(:request_for_teaching_assistant) { FactoryGirl.create :request_for_teaching_assistant, professor_id: professor.id }
  let!(:assistant_role) { FactoryGirl.create :assistant_role }

	describe "#notify_frequency" do
		before :each do
      expect(Time).to receive(:now).and_return(now).at_least(:once)
      expect(Delayed::Job).to receive(:enqueue).with(instance_of(FrequencyMailJob), frequency_mail_params)
			expect(Delayed::Job).to receive(:enqueue).with(instance_of(FrequencyReminderJob), remainder_mail_params)
    	mail = double("mail", :deliver => nil)
			expect(NotificationMailer).to receive(:frequency_request_notification).with(professor).and_return( mail )
		end
		
		it "calls the appropriate gem method" do
			AssistantFrequency.notify_frequency
		end
		
	end
	
	describe "#notify_frequency_reminder" do
		before :each do
    		mail = double("mail", :deliver => nil)
			expect(NotificationMailer).to receive(:pending_frequencies_notification).with(array_including(assistant_role), professor).and_return( mail )
		end
		
		it "calls the appropriate gem method" do
			AssistantFrequency.notify_frequency_reminder
		end
		
	end

end
