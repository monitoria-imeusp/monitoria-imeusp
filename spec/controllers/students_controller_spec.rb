require 'spec_helper'

describe StudentsController do

  context 'when signed in without student info' do
    let(:user) { FactoryGirl.create :user }
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe '.new' do
      before :each do
        get :new
        assigns(:student).should be_a_new(Student)
      end
      subject { response }
      it { expect(subject).to render_template(:new) }
    end

    describe '.create' do

      context 'succeeds to save' do
        before :each do
          post :create, { :student => FactoryGirl.attributes_for(:student), :user => FactoryGirl.attributes_for(:user) }
        end

        it { should redirect_to User.last }

        context 'student' do
          subject { assigns(:student) }
          it { expect(subject).to be_a(Student) }
          it { expect(subject).to be_persisted() }
          its(:user_id) { should eq(user.id) }
        end
      end

      context 'fails to save' do
        before :each do
          post :create, { :student => { gender: 1 }, :user => { name: "Derp" } }
        end

        it { should render_template :new }

        context 'student' do
          subject { assigns(:student) }
          it { should be_a_new(Student) }
          it { should_not be_persisted() }
        end
      end
    end
  end

  context 'when signed in as admin' do
    login_admin

    describe '.index' do
      before :each do
        get :index
      end
      it { should render_template :index }
      context "with no students" do
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        let(:student) { FactoryGirl.create :student }
        subject { assigns(:students) }
        it { should eq([student]) }
      end
    end

  end

  context 'when signed in as professor' do
    let(:user) { FactoryGirl.create :user }
    let!(:professor) { FactoryGirl.create :professor, user_id: user.id }
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe '.index' do
      before :each do
        get :index, {}
      end
      it { should render_template :index }
      context "with no students" do
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        let(:student) { FactoryGirl.create :student }
        subject { assigns(:students) }
        it { should eq([student]) }
      end
    end
  end

  context 'when signed in as secretary' do
    login_secretary

    describe '.index' do
      before :each do
        get :index
      end
      it { should render_template :index }
      context "with no students" do
        it { assigns(:students).should eq([]) }
      end
      context "with students" do
        let(:student) { FactoryGirl.create :student }
        subject { assigns(:students) }
        it { should eq([student]) }
      end
    end
  end

  context 'when signed in as student' do
    let(:user) { FactoryGirl.create :user }
    let(:student) { FactoryGirl.create :student, user_id: user.id }
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe '.edit' do
      context 'himself or herself' do
        before :each do
          get :edit, {:id => student.id}
        end
        subject { assigns(:student) }
        it { should eq(student) }
      end
      context 'another' do
        let(:another_user) { FactoryGirl.create :another_user }
        let(:another_student) { FactoryGirl.create :student, user_id: another_user.id }
        before :each do
          get :edit, {:id => another_student.id}
        end
        it { should redirect_to('/403') }
      end
    end

    describe '.update' do
      context 'himself or herself' do
        before :each do
          put :update, {:id => student.id, :student => { address: "New address" } }
        end
        context 'with valid params' do
          subject { assigns(:student) }
          it { should eq(student) }
        end
      end
    end
  end
end
