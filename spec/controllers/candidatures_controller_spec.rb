require 'spec_helper'

describe CandidaturesController do

  include Devise::TestHelpers

  let(:valid_course_attributes) {{
    "id" => 1,
    "name" => "Mascarenhas",
    "course_code" => "MAC110",
    "department_id" => "1"
  }}

  let(:valid_second_course_attributes) {{
    "id" => 2,
    "name" => "Mascarenhas2",
    "course_code" => "MAC111",
    "department_id" => "1"
  }}

  let(:valid_third_course_attributes) {{
    "id" => 3,
    "name" => "Mascarenhas3",
    "course_code" => "MAE200",
    "department_id" => "2"
  }}

  let(:valid_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 1,
    "semester_id" => 1,
    "student_id" => 1
  }}

  let(:valid_second_candidature_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 2,
    "semester_id" => 1,
    "student_id" => 2
  }}

  let(:valid_third_candidature_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 3,
    "semester_id" => 1
  }}

  let(:valid_fourth_candidature_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 2,
    "semester_id" => 1,
    "student_id" => 3
  }}

  let(:kunio) { {
    "id" => 1,
    "password" => "prof-123",
    "email" => "kunio@ime.usp.br",
    "department_id" => "1",
    "nusp" => "2222222",
    "professor_rank" => 1,
    "confirmed_at" => Time.now
  } }

  let(:zara) { {
    "id" => 2,
    "password" => "prof-123",
    "email" => "zara@ime.usp.br",
    "department_id" => "2",
    "nusp" => "3333333",
    "professor_rank" => 2,
    "confirmed_at" => Time.now
  } }

  let(:mac_attributes) { {
    "id" => 1, "code" => "MAC"
  } }

  let(:mae_attributes) { {
    "id" => 2, "code" => "MAE"
  } }

  let(:valid_semester) {{
      "id" => 1,
      "year" => 2014,
      "parity" => 0,
      "open" => true,
      "active" => true
  }}

  let(:valid_history) {{
    "historico" => [{"coddis" => "MAC0315","nota" => "5.0","rstfim" => "A ","codtur" => "20152"},
                    {"coddis" => "MAC0300","nota" => "0.0","rstfim" => "MA","codtur" => "20161"},
                    {"coddis" => "MAC0323","nota" => "0.0","rstfim" => "T ","codtur" => "20151"},
                    {"coddis" => "MAC0420","nota" => "9.0","rstfim" => "RF","codtur" => "20142"},
                    {"coddis" => "MAC0420","nota" => "4.9","rstfim" => "RN","codtur" => "20141"},
                    {"coddis" => "MAT0111","nota" => "3.0","rstfim" => "RA","codtur" => "20121"}]
    }}

  let(:valid_session) { {} }

  let(:user) { FactoryGirl.create :user, name: "Wilson Kazuo Mizutani" }
  let(:user2) { FactoryGirl.create :user, id: "3", name: "Marco Aurelio Gerosa", email: "a@a.com", nusp: 11112 }
  let(:user3) { FactoryGirl.create :user, id: "4", name: "Edson Arantes do Nascimento", email: "b@a.com", nusp: 11113 }
  let(:user4) { FactoryGirl.create :user, id: "5", name: "Robson Calzone di Calabria", email: "c@a.com", nusp: 11114 }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:student2) { FactoryGirl.create :student2, user_id: user2.id }
  let!(:student3) { FactoryGirl.create :student3, user_id: user3.id }
  let!(:student4) { FactoryGirl.create :student4, user_id: user4.id }

  before :each do
    sign_in user
    @mac = Department.create! mac_attributes
    @mae = Department.create! mae_attributes
    @shown_candidatures = { @mac.code => [], @mae.code => [] }
    valid_attributes["student_id"] = student.id
    Course.create! valid_course_attributes
    Course.create! valid_second_course_attributes
    Course.create! valid_third_course_attributes
  end

  describe "#index" do
    context 'when seeing index as student' do
      before :each do
        get :index, {}
      end
      it { is_expected.to redirect_to action: :index_for_student, student_id: student }
    end
    context 'when seeing index as super professor' do
      let!(:semester) { FactoryGirl.create :semester }
      let(:prof_user) { FactoryGirl.create :another_user }
      let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
      before :each do
        sign_out user
        sign_in prof_user
        get :index, {}
      end
      it { is_expected.to redirect_to action: :index_for_department, semester_id: semester.id, department_id: super_professor.department }
    end
    context 'when seeing index as hiper professor' do
      let(:prof_user) { FactoryGirl.create :another_user }
      let!(:hiper_professor) { FactoryGirl.create :hiper_professor, user_id: prof_user.id }
      before :each do
        sign_out user
        sign_in prof_user
        get :index, {}
      end
      subject { assigns(:departments) }
      it { expect(subject).to eq(Department.all) }
    end
  end

  describe "#index_for_student" do
    let!(:semester) { FactoryGirl.create :semester }
    context 'when receveing response' do
      before :each do
        get :index_for_student, {student_id: student.id}
      end
      subject { response }
      it { expect(subject).to render_template(:index_for_student) }
    end

    context 'when seeing candidatures' do
      let(:candidatures) { [Candidature.create!(valid_attributes)] }
      before :each do
        Candidature.create! valid_second_candidature_attributes
        Candidature.create! valid_third_candidature_attributes
        get :index_for_student, {student_id: student.id}
      end
      subject { assigns(:candidatures) }
      it { expect(subject).to eq(candidatures) }
    end
  end

  describe "#index_for_department" do
    let!(:semester) { FactoryGirl.create :semester }
    let(:prof_user) { FactoryGirl.create :another_user }
    let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
    let!(:candidature1) { Candidature.create!(valid_attributes) }
    let!(:candidature2) { Candidature.create!(valid_second_candidature_attributes) }
    let!(:candidature3) { Candidature.create!(valid_fourth_candidature_attributes) }
    let!(:candidatures) { [[ candidature1, candidature2, candidature3], [], [], []] }
    let!(:orderedcandidatures) { [[ candidature3, candidature2, candidature1], [], [], []] }
    let!(:unrelated_candidature) { Candidature.create! valid_third_candidature_attributes }
    before do
      sign_out user
      sign_in prof_user
      get :index_for_department, { semester_id: semester.id, department_id: @mac.id}
    end

    context 'when receiving response' do
      subject { response }
      it { expect(response).to render_template(:index_for_department) }
    end

    context 'when filtering candidatures' do
      subject { assigns(:candidatures_filtered) }
      it {
          expect(subject).not_to eq(candidatures)
          expect(subject).to eq(orderedcandidatures)
      }
    end

  end

  describe "#show" do
    before :each do
      @candidature = Candidature.create! valid_attributes
      student = double(Student)
      expect_any_instance_of(Student).to receive(:history_table).and_return(valid_history)
      get :show, {:id => @candidature.to_param}, valid_session
    end

    it "assigns the requested candidature as @candidature" do
      expect(assigns(:candidature)).to eq(@candidature)
    end

    it "returns correct history from json" do
      history = assigns(:history_table)
      expect(history[0].course_name).to eq("MAT0111")
      expect(history[0].grade).to eq("3.0")
      expect(history[0].full_status).to eq("Reprovado por nota e frequência")
      expect(history[0].year_semester).to eq("20121")
      expect(history[0].year).to eq("2012")
      expect(history[0].semester).to eq("1")

      expect(history[1].full_status).to eq("Reprovado por nota")
      expect(history[1].year).to eq("2014")
      expect(history[1].semester).to eq("1")

      expect(history[2].full_status).to eq("Reprovado por frequência")
      expect(history[2].year).to eq("2014")
      expect(history[2].semester).to eq("2")

      expect(history[3].full_status).to eq("Trancado")
      expect(history[3].year).to eq("2015")
      expect(history[3].semester).to eq("1")

      expect(history[4].full_status).to eq("Aprovado")
      expect(history[4].year).to eq("2015")
      expect(history[4].semester).to eq("2")

      expect(history[5].full_status).to eq("Matriculado")
      expect(history[5].year).to eq("2016")
      expect(history[5].semester).to eq("1")
    end
  end

  describe "#new" do
    it "assigns a new candidature as @candidature" do
      expect(Semester).to receive(:find).with("1").and_return(42)
      get :new, {:semester_id => "1"}, valid_session
      expect(assigns(:candidature)).to be_a_new(Candidature)
      expect(assigns(:semester)).to be(42)
    end
  end

  describe "#edit" do
    it "assigns the requested candidature as @candidature" do
      candidature = Candidature.create! valid_attributes
      get :edit, {:id => candidature.to_param}, valid_session
      expect(assigns(:candidature)).to eq(candidature)
    end
  end

  describe "#create" do
    describe "with valid params" do
      before :each do
        mail = double(Object)
        expect(BackupMailer).to receive(:new_candidature).with(an_instance_of(Candidature)).and_return(mail)
        expect(mail).to receive(:deliver)
      end
      it "creates a new Candidature" do
        expect {
          post :create, {:candidature => valid_attributes}, valid_session
        }.to change(Candidature, :count).by(1)
      end

      it "assigns a newly created candidature as @candidature" do
        post :create, {:candidature => valid_attributes}, valid_session
        expect(assigns(:candidature)).to be_a(Candidature)
        expect(assigns(:candidature)).to be_persisted
        expect(assigns(:candidature).student_id).to eq(student.id)
      end

      it "redirects to the created candidature" do
        post :create, {:candidature => valid_attributes}, valid_session
        expect(response).to redirect_to(Candidature.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved candidature as @candidature" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Candidature).to receive(:save).and_return(false)
        post :create, {:candidature => {}}, valid_session
        expect(assigns(:candidature)).to be_a_new(Candidature)
        expect(assigns(:candidature).student_id).to eq(student.id)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Candidature).to receive(:save).and_return(false)
        post :create, {:candidature => {}}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      before :each do
        @candidature = Candidature.create! valid_attributes
        mail = double(Object)
        expect(BackupMailer).to receive(:edit_candidature).with(@candidature).and_return(mail)
        expect(mail).to receive(:deliver)
      end
      it "updates the requested candidature" do
        # Assuming there are no other candidatures in the database, this
        # specifies that the Candidature created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Candidature).to receive(:update).with({ "daytime_availability" => "false" }).and_return(true)
        put :update, {:id => @candidature.to_param, :candidature => { "daytime_availability" => "false" }}, valid_session
      end

      it "assigns the requested candidature as @candidature" do
        put :update, {:id => @candidature.to_param, :candidature => valid_attributes}, valid_session
        expect(assigns(:candidature)).to eq(@candidature)
      end

      it "redirects to the candidature" do
        put :update, {:id => @candidature.to_param, :candidature => valid_attributes}, valid_session
        expect(response).to redirect_to(@candidature)
      end
    end

    describe "with invalid params" do
      it "assigns the candidature as @candidature" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Candidature).to receive(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "daytime_availability" => "invalid value" }}, valid_session
        expect(assigns(:candidature)).to eq(candidature)
      end

      it "re-renders the 'edit' template" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Candidature).to receive(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "daytime_availability" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    before :each do
      @candidature = Candidature.create! valid_attributes
      mail = double(Object)
      expect(BackupMailer).to receive(:delete_candidature).with(@candidature).and_return(mail)
      expect(mail).to receive(:deliver)
    end
    it "destroys the requested candidature" do
      expect(Candidature).to receive(:find).with(@candidature.id.to_s).and_return(@candidature)
      expect(@candidature).to receive(:destroy)
      delete :destroy, {:id => @candidature.to_param}, valid_session
      expect(assigns(:candidature)).to eq(@candidature)
    end

    it "redirects to the candidatures list" do
      delete :destroy, {:id => @candidature.to_param}, valid_session
      expect(response).to redirect_to(candidatures_url)
    end
  end
end
