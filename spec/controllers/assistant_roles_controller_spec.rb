require 'spec_helper'

describe AssistantRolesController do

  include Devise::TestHelpers

  let(:user) { FactoryGirl.create :user }
  let(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }

  before :each do
    @semester   = FactoryGirl.create :semester
    @department = FactoryGirl.create :department
    @course1    = FactoryGirl.create :course1
    @student    = FactoryGirl.create :student, user_id: user.id
    @request_for_teaching_assistant = FactoryGirl.create :request_for_teaching_assistant, professor_id: super_professor.id
    @assistant_role = FactoryGirl.create :assistant_role
    sign_in prof_user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "indexes roles by semester" do
      pending "TODO"
    end
  end

  describe "POST 'create'" do
    describe "with valid parameters" do
      before :each do
        @params = {
          "request_for_teaching_assistant_id" => @request_for_teaching_assistant.id.to_s,
          "student_id" => @student.id.to_s
        }
        #@assistant_role = FactoryGirl.create :assistant_role
        #AssistantRole.should_receive(:new).with(@params).and_return(@assistant_role)
        post 'create', @params
      end

      it "redirects back to the request" do
        response.should redirect_to @request_for_teaching_assistant
      end
    end

    describe "with invalid parameters" do
      it "redirects back to the request?" do
        pending "what should happen here?"
      end
    end
  end

  describe "POST 'deactivate'" do
    before :each do
      @params = {"id" => @assistant_role.id.to_s}
      post 'deactivate_assistant_role', @params
    end

    context "response" do
      subject { response }
      it { expect(subject).to redirect_to('/assistant_roles') }
    end

    context "assistant role" do
      subject { assigns(:assistant_role) }
      its(:active) { should be_false }
    end

  end

  describe "DELETE 'destroy'" do
    before :each do
      @assistant_role = FactoryGirl.create :assistant_role
      @id = @assistant_role.id.to_s
      @params = { "id" => @id }
    end

    it "should be destroyed" do
      AssistantRole.should_receive(:exists?).with(@id).and_return(true)
      AssistantRole.should_receive(:find).with(@id).and_return(@assistant_role)
      @assistant_role.should_receive(:destroy)
      delete 'destroy', @params
    end

    it "returns http success" do
      delete 'destroy', @params
      response.should redirect_to assistant_roles_path
    end
  end

end
