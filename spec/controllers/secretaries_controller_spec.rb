require 'spec_helper'

describe SecretariesController do

  context 'when logged in as admin' do
    login_admin

    let(:valid_attributes) { { "nusp" => "MyString", "email" => "secretaria@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now } }

    describe "#index" do
      it "assigns all secretaries as @secretaries" do
        secretary = Secretary.create! valid_attributes
        get :index, {}
        expect(assigns(:secretaries)).to eq([secretary])
      end
    end

    describe "#show" do
      it "assigns the requested secretary as @secretary" do
        secretary = Secretary.create! valid_attributes
        get :show, {:id => secretary.to_param}
        expect(assigns(:secretary)).to eq(secretary)
      end
    end

    describe "#new" do
      it "assigns a new secretary as @secretary" do
        get :new, {}
        expect(assigns(:secretary)).to be_a_new(Secretary)
      end
    end

    describe "#edit" do
      it "assigns the requested secretary as @secretary" do
        secretary = Secretary.create! valid_attributes
        get :edit, {:id => secretary.to_param}
        expect(response).to render_template("edit")
      end
    end

    describe "#create" do
      context "with valid params" do
        it "creates a new Secretary" do
          expect {
            post :create, {:secretary => valid_attributes}
          }.to change(Secretary, :count).by(1)
        end

        it "assigns a newly created secretary as @secretary" do
          post :create, {:secretary => valid_attributes}
          expect(assigns(:secretary)).to be_a(Secretary)
          expect(assigns(:secretary)).to be_persisted
        end

        it "redirects to the created secretary" do
          post :create, {:secretary => valid_attributes}
          expect(response).to redirect_to(Secretary.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved secretary as @secretary" do
          allow_any_instance_of(Secretary).to receive(:save).and_return(false)
          post :create, {:secretary => { "nusp" => "invalid value" }}
          expect(assigns(:secretary)).to be_a_new(Secretary)
        end

        it "re-renders the 'new' template" do
          allow_any_instance_of(Secretary).to receive(:save).and_return(false)
          post :create, {:secretary => { "nusp" => "invalid value" }}
          expect(response).to render_template("new")
        end
      end
    end

    describe "#destroy" do
      it "destroys the requested secretary" do
        secretary = Secretary.create! valid_attributes
        expect {
          delete :destroy, {:id => secretary.to_param} 
        }.to change(Secretary, :count).by(-1)
      end

      it "redirects to the secretaries list" do
        secretary = Secretary.create! valid_attributes
        delete :destroy, {:id => secretary.to_param}
        expect(response).to redirect_to(secretaries_url)
      end
    end
  end

  context 'when logged in as secretary' do
    let(:valid_attributes) { { "nusp" => "MyString", "email" => "secretaria@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now } }
    let(:other_valid_attributes) { { "nusp" => "9999999", "email" => "secret@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now} }
    before :each do
      @secretary = Secretary.create! valid_attributes
      sign_in @secretary
    end

    describe "#index" do
      it "assigns all secretaries as @secretaries" do
        get :index, {}
        expect(assigns(:secretaries)).to eq([@secretary])
      end
    end

    describe "#show" do
      it "assigns the requested secretary as @secretary" do
        get :show, {:id => @secretary.to_param}
        expect(assigns(:secretary)).to eq(@secretary)
      end
    end

    describe "#edit" do
      it "assigns the requested secretary as @secretary" do
        get :edit, {:id => @secretary.to_param}
        expect(assigns(:secretary)).to eq(@secretary)
      end
    end
  
    describe "#update" do
      context "with valid params" do
        it "updates the requested secretary" do
          expect_any_instance_of(Secretary).to receive(:update).with({ "nusp" => "MyString" })
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "MyString" }}
        end

        it "assigns the requested secretary as @secretary" do
          put :update, {:id => @secretary.to_param, :secretary => valid_attributes}
          expect(assigns(:secretary)).to eq(@secretary)
        end

        #it "redirects to the secretary" do
        #  secretary = Secretary.create! other_valid_attributes
        #  put :update, {:id => secretary.to_param, :secretary => valid_attributes}
        #  response.should ?
        #end
      end

      context "with invalid params" do
        it "assigns the secretary as @secretary" do
          allow_any_instance_of(Secretary).to receive(:save).and_return(false)
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "invalid value" }}
          expect(assigns(:secretary)).to eq(@secretary)
        end

        it "re-renders the 'edit' template" do
          allow_any_instance_of(Secretary).to receive(:save).and_return(false)
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "invalid value" }}
          expect(response).to render_template("edit")
        end
      end
    end

  end

end
