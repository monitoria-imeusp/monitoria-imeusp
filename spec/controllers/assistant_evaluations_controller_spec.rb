require 'spec_helper'

describe AssistantEvaluationsController do

  include Devise::TestHelpers

  let(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }

  before :each do
    @semester   = FactoryGirl.create :semester, evaluation_period: true
    @department = FactoryGirl.create :department
    @course1    = FactoryGirl.create :course1
    @student    = FactoryGirl.create :student
    @request_for_teaching_assistant = FactoryGirl.create :request_for_teaching_assistant, professor_id: super_professor.id
    @assistant_role = FactoryGirl.create :assistant_role
    sign_in prof_user
  end

  describe "#index" do
    before :each do
      @assistant_evaluation = FactoryGirl.create :assistant_evaluation
      expect(Student).to receive(:find).with(@student.id.to_s).and_return(@student)
      get :index_for_student, { student_id: @student.id }
    end

    it { expect(response).to be_ok }

    it "assigns the student as @student" do
      expect(assigns(:student)).to eq(@student)
    end

    it "assigns all assistant_evaluations for the student as @assistant_evaluations" do
      expect(assigns(:assistant_evaluations)).to eq([@assistant_evaluation])
    end
  end

  describe "#new" do
    before :each do
      get :new, { assistant_role_id: @assistant_role.id }
    end
    describe '#assistant evaluation' do
      subject { assigns(:assistant_evaluation) }
      it { expect(subject).to be_a_new(AssistantEvaluation) }

    describe '#assistant_role_id' do
      subject { super().assistant_role_id }
      it { is_expected.to eq @assistant_role.id }
      end
    end
  end

  describe "#edit" do
    it "assigns the requested assistant_evaluation as @assistant_evaluation" do
      assistant_evaluation = FactoryGirl.create :assistant_evaluation
      expect(AssistantEvaluation).to receive(:find).with(assistant_evaluation.id.to_s).and_return(assistant_evaluation)
      get :edit, { id: assistant_evaluation.to_param }
      expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation)
    end
  end

  describe "POST create" do
    context "with valid params" do
      before :each do
        @params = {
          "assistant_role_id" => "1",
          "ease_of_contact" => "1",
          "efficiency" => "1",
          "reliability" => "1",
          "overall" => "1",
          "comment" => "MyText"
        }
        @assistant_evaluation = FactoryGirl.create :assistant_evaluation
        expect(@assistant_evaluation).to receive(:save).and_return(true)
        expect(AssistantEvaluation).to receive(:new).with(@params).and_return(@assistant_evaluation)
        post :create, { assistant_evaluation: @params }
      end

      it "assigns a newly created assistant_evaluation as @assistant_evaluation and persists it" do
        expect(assigns(:assistant_evaluation)).to be_a(AssistantEvaluation)
        expect(assigns(:assistant_evaluation)).to be_persisted
      end

      it "redirects to the created assistant_evaluation" do
        expect(response).to redirect_to(assistant_roles_for_professor_path(professor_id: super_professor.id))
      end
    end

    context "with invalid params" do
      before :each do
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        post :create, {:assistant_evaluation => { assistant_role_id: "1", index_for_student: "invalid value" }}
      end

      it "assigns a newly created but unsaved assistant_evaluation as @assistant_evaluation" do
        expect(assigns(:assistant_evaluation)).to be_a_new(AssistantEvaluation)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      before :each do
        @params = {
          "assistant_role_id" => "1",
          "ease_of_contact" => "1",
          "efficiency" => "1",
          "reliability" => "1",
          "overall" => "1",
          "comment" => "MyText"
        }
      end

      it "updates the requested assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        expect_any_instance_of(AssistantEvaluation).to receive(:update).with(@params)
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
      end

      it "assigns the requested assistant_evaluation as @assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
        expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation)
      end

      it "redirects to the assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
        expect(response).to redirect_to(assistant_roles_for_professor_path(professor_id: super_professor.id))
      end
    end

    context "with invalid params" do
      it "assigns the assistant_evaluation as @assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => { "index_for_student" => "invalid value" }}
        expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation)
      end

      it "re-renders the 'edit' template" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => { "index_for_student" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end
end