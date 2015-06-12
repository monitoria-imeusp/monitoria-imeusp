require 'spec_helper'

describe Candidature do
  
  let(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }
  let(:semester)   { FactoryGirl.create :semester   }
  let!(:course1)    { FactoryGirl.create :course1    }
  let!(:course2)    { FactoryGirl.create :course2    }
  let!(:course3)    { FactoryGirl.create :course3    }
  let!(:candidature1) { FactoryGirl.create :candidature1 }
  let!(:candidature2) { FactoryGirl.create :candidature2 }
  let!(:candidature3) { FactoryGirl.create :candidature3 }
  let!(:candidature4) { FactoryGirl.create :candidature4 }

  describe "create a list of candidatures for a course in a semester" do

  	it "returns a list of first option candidatures when only_first_option is true" do
  		first_option_list = Candidature.for_course_in_semester course1, semester, true
  		expect(first_option_list).to include(candidature1, candidature2)
  		expect(first_option_list).not_to include(candidature3, candidature4)
  	end

  	it "returns an empty list when there's no first option candidature" do
  		first_option_list = Candidature.for_course_in_semester course2, semester, true
  		expect(first_option_list).not_to include(candidature1, candidature2, candidature3, candidature4)
  	end

  	it "returns a list of other option candidatures when only_first_option is false" do
  		other_option_list = Candidature.for_course_in_semester course3, semester, false
  		expect(other_option_list).to include(candidature1, candidature2, candidature4)
  		expect(other_option_list).not_to include(candidature3)
  	end

  end

end
