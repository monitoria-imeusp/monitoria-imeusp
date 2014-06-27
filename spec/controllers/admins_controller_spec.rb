require 'spec_helper'

describe AdminsController do

	let(:valid_attributes) { {
    "email" => "kazuo@ime.usp.br",
    "password" => "admin123"
  } }

  let(:changed_valid_attributes) { {
    "email" => "kazuou@ime.usp.br",
    "password" => "admin456"
  } }

  context 'when logged in as admin' do
    before :each do
      @admin = Admin.create! valid_attributes
      sign_in @admin
    end

    describe 'show' do
      context 'see its own account' do
        before :each do
          get :show, {:id => @admin.to_param}
        end
        it { 
          should render_template :show 
        }
        it {
          assigns(:admin).should eq(@admin)
        }
      end
    end

    describe 'edit' do
      describe 'a request made by the signed admin' do
        it "can edit its own account" do
          get :edit, {:id => @admin.to_param}
          assigns(:admin).should eq(@admin)
        end
      end
    end

    describe 'update' do
      describe 'a request made by the signed admin' do
        describe 'with valid params' do
          it {
            put :update, {:id => @admin.to_param, :admin => changed_valid_attributes}
            assigns(:admin).should eq(@admin)
          }
        end
      end
      describe "with invalid params" do
        it "assigns the admin as @admin" do
          # Trigger the behavior that occurs when invalid params are submitted
          Admin.any_instance.stub(:save).and_return(false)
          put :update, {:id => @admin.to_param, :admin => { "email" => "" }}
          assigns(:admin).should eq(@admin)
        end
      end
    end
  end
end