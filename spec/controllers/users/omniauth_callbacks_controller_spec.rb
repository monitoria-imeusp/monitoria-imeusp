require 'spec_helper'

describe Users::OmniauthCallbacksController do

  include ControllerHelpers
  OmniAuth.config.test_mode = true

  let!(:user) { FactoryGirl.create :user, uid: 1 }
  let!(:student) { FactoryGirl.create :student, user_id: user.id }
  let!(:user2) { FactoryGirl.create :another_user, uid: 2}
  let!(:professor) { FactoryGirl.create :professor, user_id: user2.id }
  let!(:department) { FactoryGirl.create :department }

  before :each do
    request.env["devise.mapping"] = Devise.mappings[:user] 
  end

  context "student is already registered" do

    let!(:info) {{}}
    let!(:count) { User.count }

    describe ".usp" do

      before :each do
        expect(info).to receive(:nusp).at_least(1).times.and_return(11111)
        expect(info).to receive(:link).at_least(1).times.and_return(:student)
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({})
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:provider).at_least(1).times.and_return(:usp)
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:uid).at_least(1).times.and_return('1')
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:info).at_least(1).times.and_return(info)
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:usp] 
        get :usp
      end

      context 'response' do
        subject { response }
        it { expect(subject).to redirect_to('/') }
      end

      context 'user' do
        subject { assigns(:user) }
        it { expect(subject).to be_persisted }
        it { expect(subject).to eq(current_user) }

        describe '#nusp' do
          subject { super().nusp }
          it { is_expected.to be(11111) }
        end
      end

      context 'user count' do
        subject { User }

        describe '#count' do
          subject { super().count }
          it { is_expected.to be(count) }
        end
      end
    end
  end

  context "student is not registered" do

    let!(:info) {{}}
    let!(:count) { User.count }

    describe ".usp" do

      before :each do
        expect(info).to receive(:nusp).at_least(1).times.and_return(11112)
        expect(info).to receive(:name).at_least(1).times.and_return("Bruno Sesso")
        expect(info).to receive(:email).at_least(1).times.and_return("sesso@neverforget.com")
        expect(info).to receive(:link).at_least(1).times.and_return(:student)
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({})
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:info).at_least(1).times.and_return(info)
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:usp] 
        get :usp
      end

      context 'response' do
        subject { response }
        it { expect(subject).to redirect_to('/students/new') }
      end

      context 'user' do
        subject { assigns(:user) }
        it { expect(subject).to be_persisted }
        it { expect(subject).to eq(current_user) }

        describe '#nusp' do
          subject { super().nusp }
          it { is_expected.to be(11112) }
        end
      end

      context 'user count' do
        subject { User }

        describe '#count' do
          subject { super().count }
          it { is_expected.to be(count + 1) }
        end
      end
		end

	end
	
	######################
	context "professor is already registered" do

    let!(:info) {{}}
    let!(:count) { User.count }

    describe ".usp" do

      before :each do
        expect(info).to receive(:nusp).at_least(1).times.and_return(22222)
        expect(info).to receive(:link).at_least(1).times.and_return(:teacher)
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({})
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:provider).at_least(1).times.and_return(:usp)
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:uid).at_least(1).times.and_return('2')
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:info).at_least(1).times.and_return(info)
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:usp] 
        get :usp
      end

      context 'response' do
        subject { response }
        it { expect(subject).to redirect_to('/') }
      end

      context 'user' do
        subject { assigns(:user) }
        it { expect(subject).to be_persisted }
        it { expect(subject).to eq(current_user) }

        describe '#nusp' do
          subject { super().nusp }
          it { is_expected.to be(22222) }
        end
      end

      context 'user count' do
        subject { User }

        describe '#count' do
          subject { super().count }
          it { is_expected.to be(count) }
        end
      end
    end
  end
  
  #################
  context "professor is not registered" do

    let!(:info) {{}}
    let!(:count) { User.count }

    describe ".usp" do

      before :each do
        expect(info).to receive(:nusp).at_least(1).times.and_return(22223)
        expect(info).to receive(:name).at_least(1).times.and_return("Pindamoiangaba")
        expect(info).to receive(:email).at_least(1).times.and_return("sesso4eva@neverforget.com")
        expect(info).to receive(:link).at_least(1).times.and_return(:teacher)
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({})
        expect(OmniAuth.config.mock_auth[:usp]).to receive(:info).at_least(1).times.and_return(info)
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:usp] 
        get :usp
      end

      context 'response' do
        subject { response }
        it { expect(subject).to redirect_to("/professors/#{assigns(:user).professor.id}/edit") }
      end

      context 'user' do
        subject { assigns(:user) }
        it { expect(subject).to be_persisted }
        it { expect(subject).to eq(current_user) }

        describe '#nusp' do
          subject { super().nusp }
          it { is_expected.to be(22223) }
        end
      end

      context 'user count' do
        subject { User }

        describe '#count' do
          subject { super().count }
          it { is_expected.to be(count + 1) }
        end
      end
		end

	end
end
	
