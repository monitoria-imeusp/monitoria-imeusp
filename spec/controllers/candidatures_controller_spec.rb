require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CandidaturesController do

  # This should return the minimal set of attributes required to create a valid
  # Candidature. As you add validations to Candidature, be sure to
  # adjust the attributes here as well.

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
    "semester_id" => 1
  }}

  let(:valid_second_candidature_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 2,
    "semester_id" => 1
  }}

  let(:valid_third_candidature_attributes) {{
    "time_period_preference" => "Indiferente",
    "course1_id" => 3,
    "semester_id" => 1
  }}

  let(:kunio) { {
    "id" => 1,
    "password" => "prof-123",
    "email" => "kunio@ime.usp.br",
    "department_id" => 1,
    "nusp" => "2222222",
    "professor_rank" => 1,
    "confirmed_at" => Time.now
  } }

  let(:zara) { {
    "id" => 2,
    "password" => "prof-123",
    "email" => "zara@ime.usp.br",
    "department_id" => 2,
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
      "open" => true
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CandidaturesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  @student = login_student

  before :each do
    @mac = Department.create! mac_attributes
    @mae = Department.create! mae_attributes
    @shown_candidatures = { @mac.code => [], @mae.code => [] }
    valid_attributes["student_id"] = @student.id
    Course.create! valid_course_attributes
    Course.create! valid_second_course_attributes
    Course.create! valid_third_course_attributes
  end

  describe "GET index" do
    it "student assigns his candidatures as @candidatures" do
      @shown_candidatures[@mac.code].push(Candidature.create! valid_attributes)
      Candidature.create! valid_second_candidature_attributes
      Candidature.create! valid_third_candidature_attributes
      get :index, {}, valid_session
      assigns(:candidatures_filtered).should eq(@shown_candidatures)
    end
    it "super professor assigns candidatures of his department as @candidatures" do
      @shown_candidatures[@mac.code].push(
        (Candidature.create! valid_attributes),
        (Candidature.create! valid_second_candidature_attributes)
      )
      Candidature.create! valid_third_candidature_attributes
      super_professor = Professor.create! kunio
      sign_in :professor, super_professor
      get :index, {}, valid_session
      assigns(:candidatures_filtered).should eq(@shown_candidatures)
    end
    it "hiper professor assigns all candidatures as @candidatures" do
      semester = Semester.create! valid_semester
      @shown_candidatures[@mac.code].push(
        (Candidature.create! valid_attributes),
        (Candidature.create! valid_second_candidature_attributes)
      )
      @shown_candidatures[@mae.code].push(Candidature.create! valid_third_candidature_attributes)
      hiper_professor = Professor.create! zara
      sign_in :professor, hiper_professor
      get :index, {}, valid_session
      assigns(:candidatures_filtered).should eq(@shown_candidatures)
    end
  end

  describe "GET show" do
    it "assigns the requested candidature as @candidature" do
      candidature = Candidature.create! valid_attributes
      get :show, {:id => candidature.to_param}, valid_session
      assigns(:candidature).should eq(candidature)
    end
  end

  describe "GET new" do
    it "assigns a new candidature as @candidature" do
      Semester.should_receive(:find).with("1").and_return(42)
      get :new, {:id => "1"}, valid_session
      assigns(:candidature).should be_a_new(Candidature)
      assigns(:semester).should be(42)
    end
  end

  describe "GET edit" do
    it "assigns the requested candidature as @candidature" do
      candidature = Candidature.create! valid_attributes
      get :edit, {:id => candidature.to_param}, valid_session
      assigns(:candidature).should eq(candidature)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before :each do
        mail = double(Object)
        BackupMailer.should_receive(:new_candidature).with(an_instance_of(Candidature)).and_return(mail)
        mail.should_receive(:deliver)
      end
      it "creates a new Candidature" do
        expect {
          post :create, {:candidature => valid_attributes}, valid_session
        }.to change(Candidature, :count).by(1)
      end

      it "assigns a newly created candidature as @candidature" do
        post :create, {:candidature => valid_attributes}, valid_session
        assigns(:candidature).should be_a(Candidature)
        assigns(:candidature).should be_persisted
        assigns(:candidature).student_id.should eq(@student.id)
      end

      it "redirects to the created candidature" do
        post :create, {:candidature => valid_attributes}, valid_session
        response.should redirect_to(Candidature.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved candidature as @candidature" do
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        post :create, {:candidature => {}}, valid_session
        assigns(:candidature).should be_a_new(Candidature)
        assigns(:candidature).student_id.should eq(@student.id)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        post :create, {:candidature => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before :each do
        @candidature = Candidature.create! valid_attributes
        mail = double(Object)
        BackupMailer.should_receive(:edit_candidature).with(@candidature).and_return(mail)
        mail.should_receive(:deliver)
      end
      it "updates the requested candidature" do
        # Assuming there are no other candidatures in the database, this
        # specifies that the Candidature created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Candidature.any_instance.should_receive(:update).with({ "daytime_availability" => "false" }).and_return(true)
        put :update, {:id => @candidature.to_param, :candidature => { "daytime_availability" => "false" }}, valid_session
      end

      it "assigns the requested candidature as @candidature" do
        put :update, {:id => @candidature.to_param, :candidature => valid_attributes}, valid_session
        assigns(:candidature).should eq(@candidature)
      end

      it "redirects to the candidature" do
        put :update, {:id => @candidature.to_param, :candidature => valid_attributes}, valid_session
        response.should redirect_to(@candidature)
      end
    end

    describe "with invalid params" do
      it "assigns the candidature as @candidature" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "daytime_availability" => "invalid value" }}, valid_session
        assigns(:candidature).should eq(candidature)
      end

      it "re-renders the 'edit' template" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "daytime_availability" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @candidature = Candidature.create! valid_attributes
      mail = double(Object)
      BackupMailer.should_receive(:delete_candidature).with(@candidature).and_return(mail)
      mail.should_receive(:deliver)
    end
    it "destroys the requested candidature" do
      Candidature.should_receive(:find).with(@candidature.id.to_s).and_return(@candidature)
      @candidature.should_receive(:destroy)
      delete :destroy, {:id => @candidature.to_param}, valid_session
      assigns(:candidature).should eq(@candidature)
    end

    it "redirects to the candidatures list" do
      delete :destroy, {:id => @candidature.to_param}, valid_session
      response.should redirect_to(candidatures_url)
    end
  end

end
