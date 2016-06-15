require 'spec_helper'

describe CoursesController do

  include Devise::TestHelpers

  let(:valid_admin){{
    "email" => "kazuo@ime.usp.br",
    "password" => "admin123"
  }}


  before do
    @department = mock_model(Department)
    @course = mock_model(Course)
    @id = '50'
  end

  context 'when logged in as admin' do
    login_admin

    describe '#new' do
      it {
        expect(Course).to receive(:new).and_return(@course)
        get :new
        expect(assigns(:course)).to eq(@course)
      }
    end

    describe '#create' do
      before :each do
        @params = { course: {name: 'materia', course_code: 'MAC'}}
        expect(Course).to receive(:new).with(any_args).and_return(@course)
      end

      context 'when it fails to save' do
        before :each do
          expect(@course).to receive(:save).and_return(false)
          post :create, @params
        end
        it { is_expected.to render_template :new }
      end

      context 'when it succeeds to save' do
        before :each do
          expect(@course).to receive(:save).and_return(true)
          post :create, @params
        end
        it { is_expected.to redirect_to @course }
      end
    end

    describe '#show' do
      context 'when course does exist' do
        before :each do
          expect(Course).to receive(:exists?).with(@id).and_return(true)
          expect(Course).to receive(:find).with(@id).and_return(@course)
          get :show, id: @id
          expect(assigns(:course)).to eq(@course)
        end
        it { is_expected.to render_template :show}
      end
      context 'when course does not exist' do
        before :each do
          expect(Course).to receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { is_expected.to redirect_to courses_path}
      end
    end


    describe '#index' do
      before :each do
        get :index
      end
      it { is_expected.to render_template :index }
    end

    describe '#edit' do
      context 'when course does exist' do
        before :each do
          expect(Department).to receive(:find_by).with(:id => @course.department_id).and_return(@department)
          expect(@course).to receive(:course_code).and_return("MAC")
          expect(@department).to receive(:code).and_return("MAC")
          expect(Course).to receive(:exists?).with(@id).and_return(true)
          expect(Course).to receive(:find).with(@id).and_return(@course)
          get :edit, id: @id
          expect(assigns(:course)).to eq(@course)
        end
        it { is_expected.to render_template :edit }
      end

      context "when course does not exist"  do
        before :each do
          expect(Course).to receive(:exists?).with(@id).and_return(false)
          get :edit, id: @id
        end
        it { is_expected.to redirect_to courses_path }
      end
    end

    describe '#update' do
      context 'when updating a course that does not exist' do
        before :each do
          expect(Course).to receive(:exists?).with(@id).and_return(false)
          put :update, id: @id, course: { id: @id }
        end
        it { is_expected.to redirect_to course_path }
      end

      context 'when updating a course that does exist' do
        before do
          expect(Course).to receive(:exists?).with(@id).and_return(true)
          expect(Course).to receive(:find).with(@id).and_return(@course)
        end

        context 'when update fails' do
          before :each do
            expect(@course).to receive(:update).with(any_args).and_return(false)
            put :update, id: @id, course: { id: @id, course_code: "MAC" }
            expect(assigns(:course)).to eq(@course)
          end
          it { is_expected.to render_template :edit }
        end

        context 'when update succeeds' do
          before :each do
            expect(@course).to receive(:update).with(any_args).and_return(true)
            put :update, id: @id, course: { id: @id, course_code: "MAC" }
            expect(assigns(:course)).to eq(@course)
          end
          it { is_expected.to redirect_to @course }
        end
      end
    end

    describe "#destroy" do

      describe "when destroying a course" do
        before :each do
          expect(Course).to receive(:find).with(@id).and_return(@course)
          expect(@course).to receive(:destroy)
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
          expect(response).to redirect_to(courses_url)
        end
      end
    end
  end
end
