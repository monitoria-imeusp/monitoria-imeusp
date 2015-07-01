require 'spec_helper'

describe AdvisesController do

  
  let(:valid_attributes) { { "title" => "MyString", "message" => "MyText", "order" => "1" } }
  let(:valid_session) { {} }

  describe "#new" do
    it "assigns a new advise as @advise" do
      get :new, {}, valid_session
      expect(assigns(:advise)).to be_a_new(Advise)
    end
  end

  describe "#edit" do
    it "assigns the requested advise as @advise" do
      advise = Advise.create! valid_attributes
      get :edit, {:id => advise.to_param}, valid_session
      expect(assigns(:advise)).to eq(advise)
    end
  end

  describe "#create" do
    context "with valid params" do
      before :each do
        @advise = Advise.create! valid_attributes
        expect(Advise).to receive(:new).and_return(@advise)
        expect(Advise).to receive(:any?).and_return(false)
        post :create, {:advise => valid_attributes}, valid_session
      end
      it "creates a new Advise" do
        expect(assigns(:advise)).to eq(@advise)
      end

      it "assigns a newly created advise as @advise" do
        expect(assigns(:advise)).to be_a(Advise)
        expect(assigns(:advise)).to be_persisted
      end

      it "redirects to the created advise" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      before :each do
        @advise = Advise.create! valid_attributes
        expect(Advise).to receive(:new).and_return(@advise)
        expect(Advise).to receive(:any?).and_return(false)
        allow_any_instance_of(Advise).to receive(:save).and_return(false)
        post :create, {:advise => { "title" => "invalid value" }}, valid_session
      end
      it "assigns a newly created but unsaved advise as @advise" do
        expect(assigns(:advise)).to eq(@advise)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates the requested advise" do
        advise = Advise.create! valid_attributes
        expect_any_instance_of(Advise).to receive(:update).with({ "title" => "MyString" })
        put :update, {:id => advise.to_param, :advise => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested advise as @advise" do
        advise = Advise.create! valid_attributes
        put :update, {:id => advise.to_param, :advise => valid_attributes}, valid_session
        expect(assigns(:advise)).to eq(advise)
      end

      it "redirects to the advise" do
        advise = Advise.create! valid_attributes
        put :update, {:id => advise.to_param, :advise => valid_attributes}, valid_session
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid params" do
      it "assigns the advise as @advise" do
        advise = Advise.create! valid_attributes
        allow_any_instance_of(Advise).to receive(:save).and_return(false)
        put :update, {:id => advise.to_param, :advise => { "title" => "invalid value" }}, valid_session
        expect(assigns(:advise)).to eq(advise)
      end

      it "re-renders the 'edit' template" do
        advise = Advise.create! valid_attributes
        allow_any_instance_of(Advise).to receive(:save).and_return(false)
        put :update, {:id => advise.to_param, :advise => { "title" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested advise" do
      advise = Advise.create! valid_attributes
      expect {
        delete :destroy, {:id => advise.to_param}, valid_session
      }.to change(Advise, :count).by(-1)
    end

    it "redirects to the advises list" do
      advise = Advise.create! valid_attributes
      delete :destroy, {:id => advise.to_param}, valid_session
      expect(response).to redirect_to(root_url)
    end
  end
end 