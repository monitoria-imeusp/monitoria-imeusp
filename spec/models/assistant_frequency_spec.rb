require 'spec_helper'

RSpec::Matchers.define :is_time do |t1| 
	match { |t2| t1.to_s == t2.to_s }
end

describe AssistantFrequency do
  let(:params) {{ priority: 0, run_at: is_time(11.days.from_now.getutc) }}
  let(:params2) {{ priority: 0, run_at: is_time(1.months.from_now.getutc) }}
  let!(:semester) { FactoryGirl.create :semester }
  let!(:department) { FactoryGirl.create :department }
  let!(:user) { FactoryGirl.create :user }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:prof_user) { FactoryGirl.create :another_user }
  let!(:professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let!(:course1) { FactoryGirl.create :course1 }
  let!(:request_for_teaching_assistant) { FactoryGirl.create :request_for_teaching_assistant, professor_id: professor.id }
  let!(:assistant_role) { FactoryGirl.create :assistant_role }

	describe ".notify_frequency" do
		before :each do
			expect(Delayed::Job).to receive(:enqueue).with(instance_of(FrequencyReminderJob), params)
			if (Time.now.month != 6 && Time.now.month != 11)
				expect(Delayed::Job).to receive(:enqueue).with(instance_of(FrequencyMailJob), params2)
		  	end    
    		mail = double("mail", :deliver => nil)
			expect(NotificationMailer).to receive(:frequency_request_notification).with(professor).and_return( mail )
		end
		
		it "calls the appropriate gem method" do
			AssistantFrequency.notify_frequency
		end
		
	end
	
	describe ".notify_frequency_reminder" do
		before :each do
    		mail = double("mail", :deliver => nil)
			expect(NotificationMailer).to receive(:pending_frequencies_notification).with(array_including(assistant_role), professor).and_return( mail )
		end
		
		it "calls the appropriate gem method" do
			AssistantFrequency.notify_frequency_reminder
		end
		
	end

end
