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

describe SecretariesController do

  context 'when logged in as admin' do
    login_admin

    # This should return the minimal set of attributes required to create a valid
    # Secretary. As you add validations to Secretary, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { "nusp" => "MyString", "email" => "secretaria@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # SecretariesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all secretaries as @secretaries" do
        secretary = Secretary.create! valid_attributes
        get :index, {}
        assigns(:secretaries).should eq([secretary])
      end
    end

    describe "GET show" do
      it "assigns the requested secretary as @secretary" do
        secretary = Secretary.create! valid_attributes
        get :show, {:id => secretary.to_param}
        assigns(:secretary).should eq(secretary)
      end
    end

    describe "GET new" do
      it "assigns a new secretary as @secretary" do
        get :new, {}
        assigns(:secretary).should be_a_new(Secretary)
      end
    end

    describe "GET edit" do
      it "assigns the requested secretary as @secretary" do
        secretary = Secretary.create! valid_attributes
        get :edit, {:id => secretary.to_param}
        response.should render_template("edit")
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Secretary" do
          expect {
            post :create, {:secretary => valid_attributes}
          }.to change(Secretary, :count).by(1)
        end

        it "assigns a newly created secretary as @secretary" do
          post :create, {:secretary => valid_attributes}
          assigns(:secretary).should be_a(Secretary)
          assigns(:secretary).should be_persisted
        end

        it "redirects to the created secretary" do
          post :create, {:secretary => valid_attributes}
          response.should redirect_to(Secretary.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved secretary as @secretary" do
          # Trigger the behavior that occurs when invalid params are submitted
          Secretary.any_instance.stub(:save).and_return(false)
          post :create, {:secretary => { "nusp" => "invalid value" }}
          assigns(:secretary).should be_a_new(Secretary)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Secretary.any_instance.stub(:save).and_return(false)
          post :create, {:secretary => { "nusp" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested secretary" do
        secretary = Secretary.create! valid_attributes
        expect {
          delete :destroy, {:id => secretary.to_param} 
        }.to change(Secretary, :count).by(-1)
      end

      it "redirects to the secretaries list" do
        secretary = Secretary.create! valid_attributes
        delete :destroy, {:id => secretary.to_param}
        response.should redirect_to(secretaries_url)
      end
    end
  end

  context 'when logged in as secretary' do

    # This should return the minimal set of attributes required to create a valid
    # Secretary. As you add validations to Secretary, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { "nusp" => "MyString", "email" => "secretaria@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now } }
    let(:other_valid_attributes) { { "nusp" => "9999999", "email" => "secret@ime.usp.br", "password" => "12345678", "confirmed_at" => Time.now} }
    before :each do
      @secretary = Secretary.create! valid_attributes
      sign_in @secretary
    end

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # SecretariesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all secretaries as @secretaries" do
        get :index, {}
        assigns(:secretaries).should eq([@secretary])
      end
    end

    describe "GET show" do
      it "assigns the requested secretary as @secretary" do
        get :show, {:id => @secretary.to_param}
        assigns(:secretary).should eq(@secretary)
      end
    end

    describe "GET edit" do
      it "assigns the requested secretary as @secretary" do
        get :edit, {:id => @secretary.to_param}
        assigns(:secretary).should eq(@secretary)
      end
    end
  
    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested secretary" do
          # Assuming there are no other secretaries in the database, this
          # specifies that the Secretary created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Secretary.any_instance.should_receive(:update).with({ "nusp" => "MyString" })
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "MyString" }}
        end

        it "assigns the requested secretary as @secretary" do
          put :update, {:id => @secretary.to_param, :secretary => valid_attributes}
          assigns(:secretary).should eq(@secretary)
        end

        #it "redirects to the secretary" do
        #  secretary = Secretary.create! other_valid_attributes
        #  put :update, {:id => secretary.to_param, :secretary => valid_attributes}
        #  response.should ?
        #end
      end

      describe "with invalid params" do
        it "assigns the secretary as @secretary" do
          # Trigger the behavior that occurs when invalid params are submitted
          Secretary.any_instance.stub(:save).and_return(false)
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "invalid value" }}
          assigns(:secretary).should eq(@secretary)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Secretary.any_instance.stub(:save).and_return(false)
          put :update, {:id => @secretary.to_param, :secretary => { "nusp" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

  end

end
