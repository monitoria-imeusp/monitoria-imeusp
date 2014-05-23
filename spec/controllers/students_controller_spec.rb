require 'spec_helper'

describe StudentsController do

  before do
    @student = mock_model(Student)
    @id = "42"
  end

  context 'when logged in as admin' do
    login_admin

    describe 'new' do
      before :each do
        Student.should_receive(:new).and_return(nil)
        get :new
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    describe 'create' do
      before do
        @params = { student: { name: 'teste' } }
        Student.should_receive(:new).with(any_args).and_return(@student)
      end

      context 'fails to save' do
        before :each do
          @student.should_receive(:save).and_return(false)
          post :create, @params
        end
        it { should render_template :new }
      end

      context 'succeeds to save' do
        before :each do
          @student.should_receive(:save).and_return(true)
          post :create, @params
        end
        it { should redirect_to @student }
      end
    end

    describe 'show' do
      context 'student exists' do
        before :each do
          Student.should_receive(:exists?).with(@id).and_return(true)
          Student.should_receive(:find).with(@id).and_return(@student)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'student does not exist' do
        before :each  do
          Student.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to students_path }
      end
    end

    describe 'index' do
      before :each do
        Student.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end
  end

  context 'when logged in as professor' do
    login_professor

    describe 'index' do
      before :each do
        Student.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end

    describe 'show' do
      context 'student exists' do
        before :each do
          Student.should_receive(:exists?).with(@id).and_return(true)
          Student.should_receive(:find).with(@id).and_return(@student)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'student does not exist' do
        before :each  do
          Student.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to students_path }
      end
    end

  end
end
