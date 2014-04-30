require 'spec_helper'

describe CoursesController do

	 include Devise::TestHelpers

	let(:valid_admin){{
		"email" => "kazuo@ime.usp.br",
		"password" => "admin123"
		}}
	before do
		@course = mock_model(Course)
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

end
