require 'spec_helper'

describe UsersController do

  context 'when signed as admin' do
    login_admin
    
    describe '.destroy' do
    
      context 'student user' do
        let(:user) { FactoryGirl.create :user }
        let(:student) { FactoryGirl.create :student, user_id: user.id }
        
        before :each do
          expect(User.exists? (user.id)).to eq(true)
          delete :destroy, { id: user.id }
        end
        
        it { should redirect_to "/" }
        subject { assigns(:user) }
        it { should eq(user) }

        it { expect(User.exists? (user.id)).to eq(false) }
      end
    end
  end

  context 'when signed as secretary' do
    login_secretary
    
    describe '.destroy' do
    
      context 'student user' do
        let(:user) { FactoryGirl.create :user }
        let(:student) { FactoryGirl.create :student, user_id: user.id }
        
        before :each do
          expect(User.exists? (user.id)).to eq(true)
          delete :destroy, { id: user.id }
        end
        
        it { should redirect_to "/" }
        subject { assigns(:user) }
        it { should eq(user) }

        it { expect(User.exists? (user.id)).to eq(false) }
      end
    end
  end
  
  context 'when signed as student' do
    let(:user) { FactoryGirl.create :user }
    let(:student) { FactoryGirl.create :student, user_id: user.id }
    before :each do
      sign_in user
    end
    
    describe '.destroy' do
    
      context 'himself' do
        
        before :each do
          expect(User.exists? (user.id)).to eq(true)
          delete :destroy, { id: user.id }
        end
        
        it { should redirect_to('/403') }
        context 'database check' do
          it { expect(User.exists? (user.id)).to eq(true) }
        end
      end
      
      context 'others' do
        let(:user2) { FactoryGirl.create :another_user }
        let(:student2) { FactoryGirl.create :student, user_id: user2.id, id: 2 }
        
        before :each do
          expect(User.exists? (user2.id)).to eq(true)
          delete :destroy, { id: user2.id }
        end
        
        it { should redirect_to('/403') }
        context 'database check' do
          it { expect(User.exists? (user2.id)).to eq(true) }
        end
      end
    end
  end
  
  context 'when signed as professor' do
    let(:user) { FactoryGirl.create :user }
    let(:professor) { FactoryGirl.create :professor, user_id: user.id }
    before :each do
      sign_in user
    end
    
    describe '.destroy' do
      
      context 'student user' do
        let(:user2) { FactoryGirl.create :another_user }
        let(:student2) { FactoryGirl.create :student, user_id: user2.id }
        
        before :each do
          expect(User.exists? (user2.id)).to eq(true)
          delete :destroy, { id: user2.id }
        end
        
        it { should redirect_to('/403') }
        context 'database check' do
          it { expect(User.exists? (user2.id)).to eq(true) }
        end
      end
    end
  end

end

