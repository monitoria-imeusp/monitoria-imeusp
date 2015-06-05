require 'spec_helper'

describe RequestForTeachingAssistantsController do

  include Devise::TestHelpers

  let(:valid_attributes) { {
    "professor_id" => "1",
    "course_id" => "1",
    "requested_number" => 1,
    "priority" => 0,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => true,
    "observation" => "teste",
    "semester_id" => 1
  } }

  let(:not_owned_attributes) { {
    "professor_id" => "2",
    "course_id" => "2",
    "requested_number" => 2,
    "priority" => 2,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => false,
    "observation" => "teste",
    "semester_id" => 1
  } }

  let(:other_department_attributes) { {
    "professor_id" => "3",
    "course_id" => "3",
    "requested_number" => 2,
    "priority" => 2,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => false,
    "observation" => "teste",
    "semester_id" => 1
  } }

  let(:valid_course_attributes) {{
    "name" => "Mascarenhas",
    "id" => 1,
    "course_code" => "MAC110",
    "department_id" => "1"
  }}

  let(:valid_second_course_attributes) {{
    "name" => "Mascarenhas2",
    "id" => 2,
    "course_code" => "MAC111",
    "department_id" => "1"
  }}

  let(:valid_third_course_attributes) {{
    "name" => "Mascarenhas3",
    "id" => 3,
    "course_code" => "MAE200",
    "department_id" => "2"
  }}

  let(:not_owned_other_department_attributes) { {
    "professor_id" => "3",
    "course_id" => "3",
    "requested_number" => 2,
    "priority" => 2,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => false,
    "observation" => "teste",
    "semester_id" => 1
  } }

  let(:valid_professor) { {
    "id" => 1,
    "password" => "prof-123",
    "email" => "prof@ime.usp.br",
    "nusp" => "1234567",
    "department_id" => 1,
    "confirmed_at" => Time.now
  } }

  let(:another_professor_same_department) { {
    "id" => 2,
    "password" => "prof-123",
    "email" => "prof2@ime.usp.br",
    "nusp" => "7654321",
    "department_id" => 1,
    "confirmed_at" => Time.now
  } }

  let(:another_professor_another_department) { {
    "id" => 3,
    "password" => "prof-123",
    "email" => "prof3@ime.usp.br",
    "nusp" => "7777777",
    "department_id" => 2,
    "confirmed_at" => Time.now
  } }

  let(:super_professor_same_department) { {
    "id" => 4,
    "password" => "prof-123",
    "email" => "super@ime.usp.br",
    "department_id" => 1,
    "nusp" => "1111111",
    "professor_rank" => 1,
    "confirmed_at" => Time.now
  } }

  let(:zara) { {
    "id" => 5,
    "password" => "prof-123",
    "email" => "zara@ime.usp.br",
    "department_id" => 1,
    "nusp" => "1726354",
    "professor_rank" => 2,
    "confirmed_at" => Time.now
  } }

  let(:valid_semester) {{
      "id" => 1,
      "year" => 2014,
      "parity" => 0,
      "open" => true,
      "active" => true
  }}


  let(:prof_user) { FactoryGirl.create :user }
  let!(:professor) { FactoryGirl.create :professor, user_id: prof_user.id }
  before :each do
    Department.create! {{"id" => 1, "code" => "MAC"}}
    Department.create! {{"id" => 2, "code" => "MAE"}}
    @semester = Semester.create! (valid_semester)
    Course.create! valid_course_attributes
    sign_in prof_user
  end

  describe "GET index" do
    it "assigns all request_for_teaching_assistants as @request_for_teaching_assistants" do
      request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
      get :index_for_semester, { :semester_id => @semester.id }
      expect(assigns(:request_for_teaching_assistants)).to eq([request_for_teaching_assistant])
    end
  end

  describe "GET show" do
    it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
      request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
      get :show, {:id => request_for_teaching_assistant.to_param}
      expect(assigns(:request_for_teaching_assistant)).to eq(request_for_teaching_assistant)
    end
  end

  describe "GET new" do
    it "assigns a new request_for_teaching_assistant as @request_for_teaching_assistant" do
      get :new, {:semester_id => "1"}
      expect(assigns(:request_for_teaching_assistant)).to be_a_new(RequestForTeachingAssistant)
    end
  end

  describe "GET edit" do
    describe "a request from the signed professor" do
      it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        get :edit, {:id => request_for_teaching_assistant.to_param}
        expect(assigns(:request_for_teaching_assistant)).to eq(request_for_teaching_assistant)
      end
    end

    describe "edit a request not from the signed professor" do
      it "redirects back to the request list" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! not_owned_attributes
        get :edit, {:id => request_for_teaching_assistant.to_param}
        is_expected.to redirect_to('/403')
      end
    end
  end

  describe "POST create" do

    it "uses the current signed professor's id" do
      post :create, {:request_for_teaching_assistant => valid_attributes}, valid_session
      expect(assigns(:request_for_teaching_assistant).professor_id).to be(valid_professor["id"])
    end

    describe "with valid params" do
      it "creates a new RequestForTeachingAssistant" do
        count_before = RequestForTeachingAssistant.count
        assert(!RequestForTeachingAssistant.exists?(valid_attributes[:id]))
        post :create, {:request_for_teaching_assistant => valid_attributes}
        count_after = RequestForTeachingAssistant.count
        expect(count_before+1).to equal(count_after)
      end

      it "assigns a newly created request_for_teaching_assistant as @request_for_teaching_assistant" do
        post :create, {:request_for_teaching_assistant => valid_attributes}
        expect(assigns(:request_for_teaching_assistant)).to be_a(RequestForTeachingAssistant)
        expect(assigns(:request_for_teaching_assistant)).to be_persisted
      end

      it "redirects to the created request_for_teaching_assistant" do
        post :create, {:request_for_teaching_assistant => valid_attributes}
        expect(response).to redirect_to(RequestForTeachingAssistant.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved request_for_teaching_assistant as @request_for_teaching_assistant" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(RequestForTeachingAssistant).to receive(:save).and_return(false)
        post :create, {:request_for_teaching_assistant => {}}
        expect(assigns(:request_for_teaching_assistant)).to be_a_new(RequestForTeachingAssistant)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(RequestForTeachingAssistant).to receive(:save).and_return(false)
        post :create, {:request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        expect_any_instance_of(RequestForTeachingAssistant).to receive(:update).with({ "professor_id" => "1" })
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "1" }}
      end

      it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => valid_attributes}
        expect(assigns(:request_for_teaching_assistant)).to eq(request_for_teaching_assistant)
      end

      it "redirects to the request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => valid_attributes}
        expect(response).to redirect_to(request_for_teaching_assistant)
      end
    end

    describe "with invalid params" do
      it "assigns the request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        allow_any_instance_of(RequestForTeachingAssistant).to receive(:save).and_return(false)
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        expect(assigns(:request_for_teaching_assistant)).to eq(request_for_teaching_assistant)
      end

      it "re-renders the 'edit' template" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        allow_any_instance_of(RequestForTeachingAssistant).to receive(:save).and_return(false)
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    describe "a request from the signed professor" do
      it "destroys the requested request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        expect {
          delete :destroy, {:id => request_for_teaching_assistant.to_param}
        }.to change(RequestForTeachingAssistant, :count).by(-1)
      end

      it "redirects to the request_for_teaching_assistants list" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        delete :destroy, {:id => request_for_teaching_assistant.to_param}
        expect(response).to redirect_to(request_for_teaching_assistants_url)
      end
    end

    describe "a request not from the signed professor" do
      it "gives access denied" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! not_owned_attributes
        delete :destroy, {:id => request_for_teaching_assistant.to_param}
        is_expected.to redirect_to('/403')
      end
    end
  end

  describe ".index_for_semester" do

    let(:valid_request1) { {
      "professor_id" => "4",
      "course_id" => "1",
      "requested_number" => 1,
      "priority" => 0,
      "student_assistance" => true,
      "work_correction" => false,
      "test_oversight" => true,
      "observation" => "teste",
      "semester_id" => 1
    } }

    let(:valid_request2) { {
      "professor_id" => "5",
      "course_id" => "2",
      "requested_number" => 2,
      "priority" => 2,
      "student_assistance" => true,
      "work_correction" => false,
      "test_oversight" => false,
      "observation" => "teste",
      "semester_id" => 1
    } }

    let(:valid_request3) { {
      "professor_id" => "6",
      "course_id" => "3",
      "requested_number" => 2,
      "priority" => 2,
      "student_assistance" => true,
      "work_correction" => false,
      "test_oversight" => false,
      "observation" => "teste",
      "semester_id" => 1
    } }

    let(:puser1) { FactoryGirl.create :user, id: "4", name: "Marco Aurelio Gerosa", email: "a@a.com", nusp: 11112 }
    let(:puser2) { FactoryGirl.create :user, id: "5", name: "Edson Arantes do Nascimento", email: "b@a.com", nusp: 11113 }
    let(:puser3) { FactoryGirl.create :user, id: "6", name: "Robson Calzone di Calabria", email: "c@a.com", nusp: 11114 }
    let!(:professor1) { FactoryGirl.create :professor, id: 4, department_id: 1,  user_id: puser1.id }
    let!(:professor2) { FactoryGirl.create :professor, id: 5, department_id: 1,  user_id: puser2.id }
    let!(:professor3) { FactoryGirl.create :professor, id: 6, department_id: 2, user_id: puser3.id }

    let!(:request1) { RequestForTeachingAssistant.create! valid_request1 }
    let!(:request2) { RequestForTeachingAssistant.create! valid_request2 }
    let!(:request3) { RequestForTeachingAssistant.create! valid_request3 }

    it "filters the requests of other professors" do
      Course.create! valid_second_course_attributes
      request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
      RequestForTeachingAssistant.create! not_owned_attributes
      get :index_for_semester, { :semester_id => @semester.id }
      expect(assigns(:request_for_teaching_assistants)).to eq([request_for_teaching_assistant])
    end
    context 'as super professor' do
      let!(:courses) {
        Course.create! valid_second_course_attributes
        Course.create! valid_third_course_attributes
      }
      let(:super_prof_user) { FactoryGirl.create :another_user }
      let!(:super_professor) { FactoryGirl.create :super_professor, user_id: super_prof_user.id }
      let!(:shown_requests) { [ request2, request1 ] }        
      let!(:not_shown_requests) {
        RequestForTeachingAssistant.create! not_owned_other_department_attributes
        RequestForTeachingAssistant.create! other_department_attributes
      }
      before :each do
        sign_out :prof_user
        sign_in super_prof_user
        get :index_for_semester, { :semester_id => @semester.id }
      end
      subject { assigns(:request_for_teaching_assistants) }
      it { expect(subject).to eq(shown_requests) }
    end

    context 'as hiper professor' do
      let!(:courses) {
        Course.create! valid_second_course_attributes
        Course.create! valid_third_course_attributes
      }
      let(:hiper_prof_user) { FactoryGirl.create :another_user }
      let!(:hiper_professor) { FactoryGirl.create :hiper_professor, user_id: hiper_prof_user.id }
      let!(:shown_requests) { [ request2, request1, request3 ] }   
      before :each do
        sign_out :prof_user
        sign_in hiper_prof_user
        get :index_for_semester, { :semester_id => @semester.id }
      end
      subject { assigns(:request_for_teaching_assistants) }
      it { expect(subject).to eq(shown_requests) }
    end

  end
end
