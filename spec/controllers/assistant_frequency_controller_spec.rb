require 'spec_helper'

describe AssistantFrequencyController do
  
  let!(:semester) { FactoryGirl.create :semester }
  let!(:department) { FactoryGirl.create :department }
  let!(:user) { FactoryGirl.create :user }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let!(:course1) { FactoryGirl.create :course1 }
  let!(:request_for_teaching_assistant) { FactoryGirl.create :request_for_teaching_assistant, professor_id: super_professor.id }
  let!(:assistant_role) { FactoryGirl.create :assistant_role }
  
  describe ".request_frequency" do
  end

  describe ".mark_assistant_role_frequency" do
  
    context "when marking presence" do
      before :each do
        @params = { "presence" => "true", "month" => "5", "role" => assistant_role.id.to_s, "pid" => super_professor.id.to_s}
        post 'mark_assistant_role_frequency', @params
      end
      
      context "when redirected" do
      end
      context "with correct attributes" do
        subject { assigns(:assistant_frequency) }
        its(:presence) { should be_true }
        its(:month) { should eq(5) }
        its(:assistant_role_id) { should eq(assistant_role.id) }
      end
      context "when DB is updated" do
        subject { assigns(:assistant_frequency) }
        it { should be_persisted }
      end
    end
    
    context "when marking absence" do
      pending "SHAIZA"
    end
    
    context "when passing invalid arguments" do
      pending "ALLAHUAKBHAR"
    end
  
  end
  
end
