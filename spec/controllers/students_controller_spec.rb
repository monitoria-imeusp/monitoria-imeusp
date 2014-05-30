require 'spec_helper'

describe StudentsController do

  let(:valid_attributes) { {
  "name" => "carlinhos",
  "nusp" => "123456",
  "gender" => "0",
  "rg" => "4523654",
  "password" => "Yeieieieie",
  "cpf" => "651651561",
  "adress" => "rua do nada sem número",
  "district" => "nerdlandia",
  "zipcode" => "3256874",
  "city" => "feliz feliz",
  "state" => "felizlandia",
  "tel" => "0123456789",
  "cel" => "0123456789",
  "email" => "easy@facil.com"
  } }

  before do
    @student = mock_model(Student)
    @id = "42"
  end

  context 'when user is not logged' do

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

    describe 'edit student' do
      context 'a request made by anyone' do
        it "can not edit a student" do
          another_student = Student.create! valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
    end
  end

  context 'when logged in as admin' do
    login_admin

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

    describe 'delete' do
      context 'student exists' do
        it "destroys the requested student" do
          student = Student.create! valid_attributes

          expect {
            delete :destroy, {:id => student.to_param}
          }.to change(Student, :count).by(-1)
        end

        it "redirects to the students list" do
          student = Student.create! valid_attributes

          delete :destroy, {:id => student.to_param}
          response.should redirect_to(students_path)
        end

      end

    end

    describe 'edit student' do
      context 'a request made by the admin' do
        it "can not edit a student" do
          another_student = Student.create! valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
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
    describe 'edit student' do
      context 'a request made by the professor' do
        it "can not edit a student" do
          another_student = Student.create! valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
    end

  end

  context 'when logged in as secretary' do
    login_secretary

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

    describe 'delete' do
      context 'student exists' do
        it "destroys the requested student" do
          student = Student.create! valid_attributes

          expect {
            delete :destroy, {:id => student.to_param}
          }.to change(Student, :count).by(-1)
        end

        it "redirects to the students list" do
          student = Student.create! valid_attributes

          delete :destroy, {:id => student.to_param}
          response.should redirect_to(students_path)
        end

      end

    end

    describe 'edit student' do
      context 'a request made by the secretary' do
        it "can not edit a student" do
          another_student = Student.create! valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
    end

  end

  context 'when logged in as student' do
    before :each do
      @student = FactoryGirl.create(:student)
      sign_in @student
    end

    describe 'edit' do
      context 'a request made by the signed student' do
        it "can edit your account" do
          get :edit, {:id => @student.to_param}
          assigns(:student).should eq(@student)
        end
        it "can not edit an account of another student" do
          another_student = Student.create! valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
    end
  end
end
