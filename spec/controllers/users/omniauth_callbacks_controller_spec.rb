require 'spec_helper'

describe Users::OmniauthCallbacksController do

	include Devise::TestHelpers

	OmniAuth.config.test_mode = true



	let!(:user) { FactoryGirl.create :user, uid: 1 }
	let!(:student) { FactoryGirl.create :student, user_id: user.id }

	before do 
  		request.env["devise.mapping"] = Devise.mappings[:user] 
  		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:usp] 
	end

	describe "authentication attempt" do

		it "redirect authenticated student to starting page" do

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
		end

		it "redirect new authenticated student to new student form" do

			OmniAuth.config.mock_auth[:usp] = OmniAuth::AuthHash.new({
      			:provider => 'USP',
      			:uid => '2',
      			:info => { :nusp => 11112,
		      			   :name => "Bruno Sesso",
		      			   :email => "sesso@neverforget.com",
		      			   :link => :student
      			}
    		})

			visit user_omniauth_callback_path(:usp)
			should redirect_to('/students/new')
    		OmniAuth.config.mock_auth[:usp] = nil

		end

	end
end
	
