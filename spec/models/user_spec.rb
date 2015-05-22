require 'spec_helper'

describe User do
	
	let!(:user) { FactoryGirl.create :user, uid: 1 }
	let!(:user2) { FactoryGirl.create :another_user, uid: 2 }
	let!(:student) { FactoryGirl.create :student, user_id: user.id }
	let!(:professor) { FactoryGirl.create :professor, user_id: user2.id }
	let!(:department) { FactoryGirl.create :department }

	let!(:info1) {{ }}
	let!(:info2) {{ }}
	let!(:info3) {{ }}
	let!(:info4) {{ }}

    let!(:auth1) {{ }}
    let!(:auth2) {{ }}
    let!(:auth3) {{ }}
    let!(:auth4) {{ }}


	describe "student authentication" do 


		it "return an user if the authenticated student already exists" do
			#info1.should_receive(:name).and_return("Bruno Sesso")
			info1.should_receive(:nusp).at_least(1).times.and_return(student.nusp)
			#info1.should_receive(:email).and_return("sesso@neverforget.com")
			info1.should_receive(:link).and_return(:student)

			auth1.should_receive(:info).at_least(1).times.and_return(info1)
			auth1.should_receive(:provider).and_return("bla")
			auth1.should_receive(:uid).and_return(2)


			returned_user = User.from_omniauth auth1
			returned_user.nusp.should eq (student.nusp)
		end

		it "create an user if the authenticated student does not exist" do
			info2.should_receive(:name).and_return("Bruno Sesso")
			info2.should_receive(:nusp).at_least(1).times.and_return(11112)
			info2.should_receive(:email).and_return("sesso@neverforget.com")
			info2.should_receive(:link).and_return(:student)

			auth2.should_receive(:info).at_least(1).times.and_return(info2)

			
			returned_user = User.from_omniauth auth2
			registered = User.where nusp: returned_user.nusp
			
			expect(registered.any?).to be_true
		end

	end

	describe "professor authentication" do 


		it "return an user if the authenticated professor already exists" do
			info3.should_receive(:nusp).at_least(1).times.and_return(professor.nusp)
			#info3.should_receive(:name).and_return("Nina S. T. Hirata")
			#info3.should_receive(:email).and_return("nina@ime.usp.br")
			info3.should_receive(:link).at_least(1).times.and_return(:teacher)

			auth3.should_receive(:info).at_least(1).times.and_return(info3)
			auth3.should_receive(:provider).and_return("bla")
			auth3.should_receive(:uid).and_return(2)


			returned_user = User.from_omniauth auth3
			returned_user.nusp.should eq (professor.nusp)
		end
		
		it "create an user if the authenticated professor does not exist" do
			info4.should_receive(:name).and_return("Mateus Barros Rodrigues")
			info4.should_receive(:nusp).at_least(1).times.and_return(6666666)
			info4.should_receive(:email).and_return("mlordx@curtobeterraba.legumes")
			info4.should_receive(:link).and_return(:teacher)

			auth4.should_receive(:info).at_least(1).times.and_return(info4)

			
			returned_user = User.from_omniauth auth4
			registered = User.where nusp: returned_user.nusp
			
			expect(registered.any?).to be_true
		end

	end
end
