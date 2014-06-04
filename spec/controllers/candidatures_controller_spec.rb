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
  let(:valid_attributes) {{
      "time_period_preference" => "Indiferente",
      "course1_id" => 1
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CandidaturesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  @student = login_student

  describe "GET index" do
    it "assigns all candidatures as @candidatures" do
      candidature = Candidature.create! valid_attributes
      get :index, {}, valid_session
      assigns(:students).should eq([@student])
      assigns(:courses).should eq([])
      assigns(:candidatures).should eq([candidature])
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
      get :new, {}, valid_session
      assigns(:candidature).should be_a_new(Candidature)
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
      it "updates the requested candidature" do
        candidature = Candidature.create! valid_attributes
        # Assuming there are no other candidatures in the database, this
        # specifies that the Candidature created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Candidature.any_instance.should_receive(:update).with({ "avaliability_daytime" => "false" })
        put :update, {:id => candidature.to_param, :candidature => { "avaliability_daytime" => "false" }}, valid_session
      end

      it "assigns the requested candidature as @candidature" do
        candidature = Candidature.create! valid_attributes
        put :update, {:id => candidature.to_param, :candidature => valid_attributes}, valid_session
        assigns(:candidature).should eq(candidature)
      end

      it "redirects to the candidature" do
        candidature = Candidature.create! valid_attributes
        put :update, {:id => candidature.to_param, :candidature => valid_attributes}, valid_session
        response.should redirect_to(candidature)
      end
    end

    describe "with invalid params" do
      it "assigns the candidature as @candidature" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "avaliability_daytime" => "invalid value" }}, valid_session
        assigns(:candidature).should eq(candidature)
      end

      it "re-renders the 'edit' template" do
        candidature = Candidature.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Candidature.any_instance.stub(:save).and_return(false)
        put :update, {:id => candidature.to_param, :candidature => { "avaliability_daytime" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested candidature" do
      candidature = Candidature.create! valid_attributes
      Candidature.should_receive(:find).with(candidature.id.to_s).and_return(candidature)
      candidature.should_receive(:destroy)
      delete :destroy, {:id => candidature.to_param}, valid_session
      assigns(:candidature).should eq(candidature)
    end

    it "redirects to the candidatures list" do
      candidature = Candidature.create! valid_attributes
      delete :destroy, {:id => candidature.to_param}, valid_session
      response.should redirect_to(candidatures_url)
    end
  end

end
