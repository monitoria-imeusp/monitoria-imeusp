require 'spec_helper'

describe AssistantRole do
  
  let(:params) {{ priority: 0, run_at: is_time(3.days.from_now.getutc) }}
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
  let!(:assistant_frequency1) { FactoryGirl.create :assistant_frequency, month: 3, presence: true}
  let!(:assistant_frequency2) { FactoryGirl.create :assistant_frequency, month: 4, presence: false}
  
  describe ".frequency_status_for_month" do
		
		context "when presence is true" do
		  subject { assistant_role.frequency_status_for_month 3 }
		  it { is_expected.to eq("Presente") }
		end
		
		context "when presence is false" do
		  subject { assistant_role.frequency_status_for_month 4 }
		  it { is_expected.to eq("Ausente") }
		end
		
		context "when there is no presence" do
		  subject { assistant_role.frequency_status_for_month 5 }
		  it { is_expected.to eq("Pendente") }
		end
		
		context "when there is no presence and role is deactivated" do
		  before :each do
		    assistant_role.deactivate
	    end
		  subject { assistant_role.frequency_status_for_month 5 }
		  it { is_expected.to eq("---") }
		end
  end
end
