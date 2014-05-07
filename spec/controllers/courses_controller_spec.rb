require 'spec_helper'

describe CoursesController do

	 include Devise::TestHelpers

	let(:valid_admin){{
		"email" => "kazuo@ime.usp.br",
		"password" => "admin123"
		}}


	before do
		@course = mock_model(Course)
		@id = '50'
		admin = Admin.create! valid_admin
    	sign_in :admin, admin
	end

	describe 'new' do
		it {
			Course.should_receive(:new).and_return(@course)
			get :new
			assigns(:course).should eq(@course)
		}
	end

	describe 'create' do
	  before :each do
		@params = { course: {name: 'materia'}}
	    Course.should_receive(:new).with(any_args).and_return(@course)
	  end

      context 'fails to save' do
      	before :each do
          @course.should_receive(:save).and_return(false)
          post :create, @params
        end
        it { should render_template :new }
      end

      context 'succeeds to save' do
        before :each do
          @course.should_receive(:save).and_return(true)
          post :create, @params
      	end
        it { should redirect_to @course }
      end
	end

	describe 'show' do
		context 'course does exist' do
		  before :each do
			Course.should_receive(:exists?).with(@id).and_return(true)
        	Course.should_receive(:find).with(@id).and_return(@course)
        	get :show, id: @id
        	assigns(:course).should eq(@course)
          end
          it {should render_template :show}
		end
		context 'course does not exist' do
		  before :each do
			Course.should_receive(:exists?).with(@id).and_return(false)
			get :show, id: @id
		  end
		  it {should redirect_to courses_path}
		end
	end
end
