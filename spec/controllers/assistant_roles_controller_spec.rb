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

  describe ".index" do
    before :each do
      get :index
    end
      
    context "when http success" do
      it { expect(response).to respond_with(:success) }
    end

    context "with roles by semester" do
      subject { assigns(:assistant_roles_by_semester)[0] }
      it { expect(subject[:semester]).to eq(semester) }
      it { expect(subject[:role][0]).to eq(assistant_role) }
    end
  end

  describe ".create" do
    context "with valid parameters" do
      before :each do
        subject { post 'create', { "request_for_teaching_assistant_id" => request_for_teaching_assistant.id.to_s, "student_id" => student.id.to_s } }
      end

      it { expect(subject).to redirect_to(request_for_teaching_assistant) }
    end

    context "with invalid request" do 
      before :each do
        subject { post 'create', { "request_for_teaching_assistant_id" => "666", "student_id" => student.id.to_s } }
      end
      
      it { expect(subject).to redirect_to('/') }
    end
    context "with invalid student" do 
      before :each do
        subject { post 'create', { "request_for_teaching_assistant_id" => request_for_teaching_assistant.id.to_s, "student_id" => "666" } }
      end
      
      it { expect(subject).to redirect_to(request_for_teaching_assistant) }
    end
  end

  describe ".deactivate" do
    before :each do
      post 'deactivate_assistant_role', {"id" => assistant_role.id.to_s}
    end

    context "response" do
      subject { response }
      it { expect(subject).to redirect_to('/assistant_roles') }
    end

    context "assistant role" do
      subject { assigns(:assistant_role) }
      it { expect(:active).to  be false }
    end

  end

  describe ".destroy" do
    before :each do
      delete 'destroy', {"id" => assistant_role.id.to_s}
    end

    context "when should be destroyed" do
      subject { AssistantRole.exists? @id }
      it { expect(subject).to be false }
    end

    context "when http return success" do
      subject { response }
      it { expect(subject).to redirect_to(assistant_roles_path) }
    end
  end

end
