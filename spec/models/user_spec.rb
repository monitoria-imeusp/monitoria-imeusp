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


	context "when authenticating as a student" do 


		it "return an user if the authenticated student already exists" do
			expect(info1).to receive(:nusp).at_least(1).times.and_return(student.nusp)
			expect(info1).to receive(:link).and_return(:student)
			expect(auth1).to receive(:info).at_least(1).times.and_return(info1)
			expect(auth1).to receive(:provider).and_return("bla")
			expect(auth1).to receive(:uid).and_return(2)

			returned_user = User.from_omniauth auth1
			expect(returned_user.nusp).to eq (student.nusp)
		end

		it "create an user if the authenticated student does not exist" do
			expect(info2).to receive(:name).and_return("Bruno Sesso")
			expect(info2).to receive(:nusp).at_least(1).times.and_return(11112)
			expect(info2).to receive(:email).and_return("sesso@neverforget.com")
			expect(info2).to receive(:link).and_return(:student)
			expect(auth2).to receive(:info).at_least(1).times.and_return(info2)
			
			returned_user = User.from_omniauth auth2
			registered = User.where nusp: returned_user.nusp			
			expect(registered.any?).to be_truthy
		end

	end

	context "when authenticating as a professor" do 


		it "return an user if the authenticated professor already exists" do
			expect(info3).to receive(:nusp).at_least(1).times.and_return(professor.nusp)
			expect(info3).to receive(:link).at_least(1).times.and_return(:teacher)
			expect(auth3).to receive(:info).at_least(1).times.and_return(info3)
			expect(auth3).to receive(:provider).and_return("bla")
			expect(auth3).to receive(:uid).and_return(2)

			returned_user = User.from_omniauth auth3
			expect(returned_user.nusp).to eq (professor.nusp)
		end
		
		it "create an user if the authenticated professor does not exist" do
			expect(info4).to receive(:name).and_return("Mateus Barros Rodrigues")
			expect(info4).to receive(:nusp).at_least(1).times.and_return(6666666)
			expect(info4).to receive(:email).and_return("mlordx@curtobeterraba.legumes")
			expect(info4).to receive(:link).and_return(:teacher)

			expect(auth4).to receive(:info).at_least(1).times.and_return(info4)

			
			returned_user = User.from_omniauth auth4
			registered = User.where nusp: returned_user.nusp
			
			expect(registered.any?).to be_truthy
		end

	end
end
