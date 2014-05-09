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


  describe 'index' do
    before :each do
      Course.should_receive(:all)
      get :index
    end
    it { should render_template :index }
  end

  describe 'edit' do
    context 'course does exist' do
      before :each do
        Course.should_receive(:exists?).with(@id).and_return(true)
        Course.should_receive(:find).with(@id).and_return(@course)
        get :edit, id: @id
        assigns(:course).should eq(@course)
      end
      it { should render_template :edit }
    end

    context "course does not exist"  do
      before :each do
        Course.should_receive(:exists?).with(@id).and_return(false)
        get :edit, id: @id
      end
      it { should redirect_to courses_path }
    end
  end

  describe 'update' do
    context 'a course that does not exist' do
      before :each do
        Course.should_receive(:exists?).with(@id).and_return(false)
        put :update, id: @id, course: { id: @id }
      end
      it { should redirect_to course_path }
    end

    context 'a course that does exist' do
      before do
        Course.should_receive(:exists?).with(@id).and_return(true)
        Course.should_receive(:find).with(@id).and_return(@course)
      end

      context 'but fails to update' do
        before :each do
          @course.should_receive(:update).with(any_args).and_return(false)
          put :update, id: @id, course: { id: @id }
          assigns(:course).should eq(@course)
        end
        it { should render_template :edit }
      end

      context 'and succeeds to update' do
        before :each do
          @course.should_receive(:update).with(any_args).and_return(true)
          put :update, id: @id, course: { id: @id }
          assigns(:course).should eq(@course)          
        end
        it { should redirect_to @course }
      end
    end
  end

  describe "destroy" do

    describe "destroy a course" do
      before :each do
      	Course.should_receive(:find).with(@id).and_return(@course)
        @course.should_receive(:destroy)
      end

      pending "should we use fixtures?" do
        it "destroys the course" do
          expect {
            delete :destroy, {:id => @id}
          }.to change(Course, :count).by(-1)
        end
      end

      it "redirects to the courses list" do
        delete :destroy, {:id => @id}
        response.should redirect_to(courses_url)
      end
    end
  end
end