require 'spec_helper'

describe Users::OmniauthCallbacksController do

	OmniAuth.config.test_mode = true

	let!(:user) { FactoryGirl.create :user, uid: 1 }
	let!(:student) { FactoryGirl.create :student, user_id: user.id }

	before :each do
		request.env["devise.mapping"] = Devise.mappings[:user] 
  end

  context "user is already registered" do

    context "redirect authenticated student to starting page" do

      it {
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({
              :provider => 'USP',
              :uid => '1',
              :info => { :nusp => 11111,
                     :name => "Wil",
                     :email => "kazuo@ime.usp.br",
                     :link => :student
              }
          })

        post :create, :provider => "USP"
        response.should redirect_to('/')
        OmniAuth.config.mock_auth[:usp] = nil
      }
    end

  end

  context "user is not registered" do

    let!(:info) {{}}
    let!(:count) { User.count }

    describe ".usp" do

      before :each do
        info.should_receive(:nusp).at_least(1).times.and_return(11112)
        info.should_receive(:name).at_least(1).times.and_return("Bruno Sesso")
        info.should_receive(:email).at_least(1).times.and_return("sesso@neverforget.com")
        info.should_receive(:link).at_least(1).times.and_return(:student)
        OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({})
        #OmniAuth.config.mock_auth[:usp].should_receive(:provider).at_least(1).times.and_return(:usp)
        #OmniAuth.config.mock_auth[:usp].should_receive(:uid).at_least(1).times.and_return('2')
        OmniAuth.config.mock_auth[:usp].should_receive(:info).at_least(1).times.and_return(info)
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
        its(:nusp) { should be(11112) }
      end

      context 'user count' do
        subject { User }
        its(:count) { should be(count + 1) }
      end
		end

	end
end
	
