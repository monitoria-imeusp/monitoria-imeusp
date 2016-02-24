require 'spec_helper'

describe AssistantRolesController do

  include Devise::TestHelpers

  let!(:semester) { FactoryGirl.create :semester }
  let!(:department) { FactoryGirl.create :department }
  let!(:user) { FactoryGirl.create :user }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let!(:course1) { FactoryGirl.create :course1 }
  let!(:request_for_teaching_assistant) { FactoryGirl.create :request_for_teaching_assistant, professor_id: super_professor.id }
  let!(:assistant_role) { FactoryGirl.create :assistant_role }

  before :each do
    sign_in prof_user
  end

  describe "#index" do
    let!(:another_semester) { FactoryGirl.create :semester, id: 2, year: 2010, open: false }
    context "for specific semester" do
      before :each do
        get :index, semester_id: semester.id
      end
        
      context "when http success" do
        it { is_expected.to respond_with(:success) }
      end

      context "with roles" do
        subject { assigns(:assistant_roles) }
        it { is_expected.to eq [assistant_role] }
      end

      context "with current semester" do
        subject { assigns(:semester) }
        it { is_expected.to eq(semester) }
      end
    end

    context "for default semester and default department" do
      before :each do
        get :index
      end
        
      context "when http success" do
        it { is_expected.to respond_with(:success) }
      end

      context "with roles" do
        subject { assigns(:assistant_roles) }
        it { is_expected.to eq [assistant_role] }
      end

      context "with current semester" do
        subject { assigns(:semester) }
        it { is_expected.to eq(another_semester) }
      end
    end
  end

  describe "#create" do
    context "with valid parameters" do
      before :each do
        post 'create', { "request_for_teaching_assistant_id" => request_for_teaching_assistant.id.to_s, "student_id" => student.id.to_s }
      end

      it { is_expected.to redirect_to(request_for_teaching_assistant) }
    end

    context "with invalid request" do 
      before :each do
        post 'create', { "request_for_teaching_assistant_id" => "666", "student_id" => student.id.to_s }
      end
      
      it { is_expected.to redirect_to('/') }
    end
    context "with invalid student" do 
      before :each do
        post 'create', { "request_for_teaching_assistant_id" => request_for_teaching_assistant.id.to_s, "student_id" => "666" }
      end
      
      it { is_expected.to redirect_to(request_for_teaching_assistant) }
    end
  end

  describe "#update" do
    context "with valid parameters" do
      before :each do
        date = DateTime.now
        patch 'update', { :id => assistant_role.id.to_s, :assistant_role =>
          {
            :student_amount => 3,
            :homework_amount => 4,
            :secondary_activity => "Não",
            :workload => 1,
            :workload_reason => "bla",
            :comment => "blabla",
            :report_creation_date => date
          }
        }
      end

      it {
        role = AssistantRole.find(assistant_role.id)
        expect(role.student_amount).to eq(3)
        expect(role.homework_amount).to eq(4)
        expect(role.secondary_activity).to eq("Não")
        expect(role.workload).to eq(1)
        expect(role.workload_reason).to eq("bla")
        expect(role.comment).to eq("blabla")
        expect(role.report_creation_date.day).to eq(DateTime.now.day)
        expect(role.report_creation_date.month).to eq(DateTime.now.month)
        expect(role.report_creation_date.year).to eq(DateTime.now.year)
        is_expected.to redirect_to(candidatures_path)
       }
    end
  end

  describe "#deactivate" do
    before :each do
      post 'deactivate_assistant_role', {"id" => assistant_role.id.to_s}
    end

    context "when getting response" do
      subject { response }
      it { expect(subject).to redirect_to('/assistant_roles') }
    end

    describe "#assistant_role" do
      subject { assigns(:assistant_role) }

      describe '#active' do
        subject { super().active }
        it { is_expected.to be_falsey }
      end
    end

  end

  describe "#certificate" do
    before :each do
      get 'certificate', {"id" => assistant_role.id.to_s}
    end

    describe "#assistant_role" do
      subject { assigns(:assistant) }
    end

  end

  describe "#destroy" do
    before :each do
      delete 'destroy', {"id" => assistant_role.id.to_s}
    end

    context "when should be destroyed" do
      subject { AssistantRole.exists? @id }
      it { is_expected.to be_falsey }
    end

    context "when http return success" do
      subject { response }
      it { is_expected.to redirect_to(assistant_roles_path) }
    end
  end
end