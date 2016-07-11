require 'spec_helper'

describe Candidature do

  let(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let!(:semester)   { FactoryGirl.create :semester   }
  let!(:course1)    { FactoryGirl.create :course1    }
  let!(:course2)    { FactoryGirl.create :course2    }
  let!(:course3)    { FactoryGirl.create :course3    }
  let!(:candidature1) { FactoryGirl.create :candidature1 }
  let!(:candidature2) { FactoryGirl.create :candidature2 }
  let!(:candidature3) { FactoryGirl.create :candidature3 }
  let!(:candidature4) { FactoryGirl.create :candidature4 }
  let!(:request1) { FactoryGirl.create :request_for_teaching_assistant }
  let!(:request2) { FactoryGirl.create :request_for_teaching_assistant, id: 2, course_id: course2.id }
  let!(:request3) { FactoryGirl.create :request_for_teaching_assistant, id: 3, course_id: course3.id }

  context "when creating a list of candidatures for a course in a semester" do

  	it "returns a list of first option candidatures for attendted request" do
  		first_option_list = Candidature.all_first_options_for_request request1
  		expect(first_option_list).to include(candidature1, candidature2)
  		expect(first_option_list).not_to include(candidature3, candidature4)
  	end

  	it "returns an empty list when there's no first option candidature" do
  		first_option_list = Candidature.all_first_options_for_request request2
  		expect(first_option_list).not_to include(candidature1, candidature2, candidature3, candidature4)
  	end

  	it "returns a list of nonfirst option candidatures for request" do
  		other_option_list = Candidature.all_nonfirst_options_for_request request3
  		expect(other_option_list).to include(candidature1, candidature2, candidature4)
  		expect(other_option_list).not_to include(candidature3)
  	end

  end

end
