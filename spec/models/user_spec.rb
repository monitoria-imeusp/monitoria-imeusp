require 'spec_helper'

describe User do
	let!(:user) { FactoryGirl.create :user }


	let!(:info1) {{ }}

	let!(:info2) {{ }}

    let!(:auth1) {{ }}

    let!(:auth2) {{ }}

	describe "student authentication" do 


		it "return an user if the authenticated student already exists" do
			info1.should_receive(:nusp).and_return(11111)
			info1.should_receive(:link).and_return(:student)

			auth1.should_receive(:info).at_least(1).times.and_return(info1)
			auth1.should_receive(:provider).and_return("bla")
			auth1.should_receive(:uid).and_return(2)


			returned_user = User.from_omniauth auth1
			returned_user.nusp.should eq (11111)
		end

		it "create an user if the authenticated student does not exist" do
			info2.should_receive(:name).and_return("Bruno Sesso")
			info2.should_receive(:nusp).at_least(1).times.and_return(11112)
			info2.should_receive(:email).and_return("sesso@neverforget.com")


			auth2.should_receive(:info).at_least(1).times.and_return(info2)

			
			returned_user = User.from_omniauth auth2
			registered = User.where nusp: returned_user.nusp
			
			expect(registered.any?).to be_true
		end

		#it "return a professor if the authenticated professor already exists" do
		#end

		


	end

end
