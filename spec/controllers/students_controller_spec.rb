require 'spec_helper'

describe StudentsController do

  let(:valid_attributes) { {
    "name" => "carlinhos",
    "nusp" => "123456",
    "gender" => "0",
    "rg" => "4523654",
    "password" => "Yeieieieie",
    "cpf" => "651651561",
    "address" => "rua do nada sem número",
    "district" => "nerdlandia",
    "zipcode" => "3256874",
    "city" => "feliz feliz",
    "state" => "felizlandia",
    "cel" => "0123456789",
    "tel" => "0123456789",
    "email" => "easy@facil.com"
  } }

  let(:another_valid_attributes) { {
    "name" => "gold",
    "nusp" => "654321",
    "gender" => "0",
    "rg" => "7654321",
    "password" => "muahahahahah",
    "cpf" => "00000000000",
    "address" => "rua do nada sem número",
    "district" => "nerdlandia",
    "zipcode" => "3256874",
    "city" => "feliz feliz",
    "state" => "felizlandia",
    "cel" => "0123456789",
    "tel" => "0123456789",
    "email" => "hard@facil.com"
  } }

  let(:changed_valid_attributes) { {
    "name" => "mandel",
    "nusp" => "123456",
    "gender" => "0",
    "rg" => "4523654",
    "password" => "Yeieieieie",
    "password_confirmation" => "Yeieieieie",
    "cpf" => "651651561",
    "address" => "rua do nada sem número",
    "district" => "nerdlandia",
    "zipcode" => "3256874",
    "city" => "feliz feliz",
    "state" => "felizlandia",
    "cel" => "0123456789",
    "tel" => "0123456789",
    "email" => "easy@facil.com"
  } }

  let(:invalid_attributes) { {
    "name" => "carlinhos",
    "nusp" => "123",
    "gender" => "0",
    "rg" => "4523654",
    "password" => "Yeieieieie",
    "cpf" => "651651561",
    "address" => "rua do nada sem número",
    "district" => "nerdlandia",
    "zipcode" => "3256874",
    "city" => "feliz feliz",
    "state" => "felizlandia",
    "cel" => "0123456789",
    "tel" => "0123456789",
    "email" => "easy@facil.com"
  } }

  before do
    @student = mock_model(Student)
    @id = "42"
  end

  context 'when user is not logged' do

    describe 'new' do
      before :each do
        get :new
        assigns(:student).should be_a_new(Student)
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    describe 'create' do      

      context 'succeeds to save' do
        before :each do
          post :create, { :student => valid_attributes }
        end
        it {
          assigns(:student).should be_a(Student)
          assigns(:student).should be_persisted()
        }
        #it { should redirect_to Student.last }
      end

      context 'fails to save' do
        before :each do
          post :create, {:student => invalid_attributes}
        end
        it { 
          should render_template :new 
        }
        it{
          assigns(:student).should be_a_new(Student)
          assigns(:student).should_not be_persisted()
        }
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
          @another_student =Student.create! valid_attributes
          get :show, {:id => @another_student.to_param}
        end
        it { 
          should render_template :show 
        }
        it {
          assigns(:student).should eq(@another_student)
        }
      end
      context 'student does not exist' do
        before :each  do
          get :show, {:id => valid_attributes}
        end
        it { should redirect_to students_path }
      end
    end

    describe 'index' do
      before :each do
        get :index
      end
      context "with no students" do
        it { should render_template :index }
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        before :each do
          @student = Student.create! valid_attributes
        end
        it { should render_template :index }
        it { assigns(:students).should eq([@student]) }
      end
    end

    describe 'delete' do
      context 'student exists' do
        before :each do
          @student = Student.create! valid_attributes
        end
        it "destroys the requested student" do
          delete :destroy, {:id => @student.to_param}
          assert(!(Student.exists?valid_attributes[:id]))
        end
        it "redirects to the students list" do
          delete :destroy, {:id => @student.to_param}
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
        get :index
      end
      context "with no students" do
        it { should render_template :index }
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        before :each do
          @student = Student.create! valid_attributes
        end
        it { should render_template :index }
        it { assigns(:students).should eq([@student]) }
      end
    end

    describe 'show' do
      context 'student exists' do
        before :each do
          @another_student =Student.create! valid_attributes
          get :show, {:id => @another_student.to_param}
        end
        it { 
          should render_template :show 
        }
        it {
          assigns(:student).should eq(@another_student)
        }
      end
      context 'student does not exist' do
        before :each  do
          get :show, {:id => valid_attributes}
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

    describe 'show' do
      context 'student exists' do
        before :each do
          @another_student =Student.create! valid_attributes
          get :show, {:id => @another_student.to_param}
        end
        it { 
          should render_template :show 
        }
        it {
          assigns(:student).should eq(@another_student)
        }
      end
      context 'student does not exist' do
        before :each  do
          get :show, {:id => valid_attributes}
        end
        it { should redirect_to students_path }
      end
    end

    describe 'index' do
      before :each do
        get :index
      end
      context "with no students" do
        it { should render_template :index }
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        before :each do
          @student = Student.create! valid_attributes
        end
        it { should render_template :index }
        it { assigns(:students).should eq([@student]) }
      end
    end

    describe 'delete' do
      context 'student exists' do
        before :each do
          @student = Student.create! valid_attributes
        end
        it "destroys the requested student" do
          delete :destroy, {:id => @student.to_param}
          assert(!(Student.exists?valid_attributes[:id]))
        end
        it "redirects to the students list" do
          delete :destroy, {:id => @student.to_param}
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

  context 'when logged in as student' do
    before :each do
      @student = Student.create! valid_attributes
      sign_in @student
    end

    describe 'edit' do
      describe 'a request made by the signed student' do
        it "can edit your account" do
          get :edit, {:id => @student.to_param}
          assigns(:student).should eq(@student)
        end
        it "can not edit an account of another student" do
          another_student = Student.create! another_valid_attributes
          get :edit, {:id => another_student.to_param}
          response.should redirect_to(students_path)
        end
      end
    end

    describe 'update' do
      describe 'a request made by the signed student' do
        describe 'with valid params' do
          it {
            put :update, {:id => @student.to_param, :student => changed_valid_attributes}
            assigns(:student).should eq(@student)
            #assigns(:student).should receive(:update).with(changed_valid_attributes)
            #assigns(:student).name.should eq(changed_valid_attributes[:name])
          }
        end
      end
    end
  end
end
