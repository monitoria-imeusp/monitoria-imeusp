require 'spec_helper'

describe ProfessorsController do

  before do
    @professor = mock_model(Professor)
    @id = "42"
  end

  let(:valid_attributes) { { "nusp" => "MyString", "email" => "professor@ime.usp.br", "password" => "12345678", "department_id" => 1 } }
  let(:other_valid_attributes) { { "nusp" => "9999999", "email" => "prof@ime.usp.br", "password" => "12345678", "department_id" => 1 } }


  context 'when logged in as admin' do
    login_admin

    describe 'new' do
      before :each do
        Professor.should_receive(:new).and_return(nil)
        get :new
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    describe 'create' do
      before do
        @params = { professor: { name: 'teste' } }
        Professor.should_receive(:new).with(any_args).and_return(@professor)
      end

      context 'fails to save' do
        before :each do
          @professor.should_receive(:save).and_return(false)
          post :create, @params
        end
        it { should render_template :new }
      end

      context 'succeeds to save' do
        before :each do
          @professor.should_receive(:save).and_return(true)
          post :create, @params
        end
        it { should redirect_to @professor }
      end
    end

    describe 'show' do
      context 'professor exists' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(@professor)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'professor does not exist' do
        before :each  do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to professors_path }
      end
    end

    describe 'index' do
      before :each do
        Professor.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end

    describe "edit" do
      it "assigns the requested professor as @professor" do
        professor = Professor.create! valid_attributes
        get :edit, {:id => professor.to_param}
        response.should redirect_to(root_path)
      end
    end

  end

  context 'when logged in as professor' do
    before :each do
      @professor = Professor.create! valid_attributes
      sign_in @professor
    end

    describe 'index' do
      before :each do
        Professor.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end

    describe 'show' do
      context 'professor exists' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(@professor)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'professor does not exist' do
        before :each  do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to professors_path }
      end
    end

    describe "GET edit" do
      it "assigns the requested professor as @professor" do
        get :edit, {:id => @professor.to_param}
        assigns(:professor).should eq(@professor)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested professor" do
          # Assuming there are no other secretaries in the database, this
          # specifies that the professor created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Professor.any_instance.should_receive(:update).with({ "nusp" => "MyString" })
          put :update, {:id => @professor.to_param, :professor => { "nusp" => "MyString" }}
        end

        it "assigns the requested professor as @professor" do
          put :update, {:id => @professor.to_param, :professor => valid_attributes}
          assigns(:professor).should eq(@professor)
        end

        it "redirects to the professor" do
          professor = Professor.create! other_valid_attributes
          put :update, {:id => professor.to_param, :professor => valid_attributes}
          response.should redirect_to(root_path)
        end
      end

      describe "with invalid params" do
        it "assigns the professor as @professor" do
          # Trigger the behavior that occurs when invalid params are submitted
          Professor.any_instance.stub(:save).and_return(false)
          put :update, {:id => @professor.to_param, :professor => { "nusp" => "invalid value" }}
          assigns(:professor).should eq(@professor)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Professor.any_instance.stub(:save).and_return(false)
          put :update, {:id => @professor.to_param, :professor => { "nusp" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end


  end
end
