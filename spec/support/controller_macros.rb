module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_professor
    let(:user) { FactoryGirl.create :user }
    let(:professor) { FactoryGirl.create :professor, user_id: user.id }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      print user.inspect
      sign_in user
    end
  end

  def login_super_professor
    @professor = 1
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:professor]
      @professor = FactoryGirl.create(:super_professor)
      sign_in @professor
    end
    return @professor
  end

  def login_secretary
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:secretary]
      sign_in FactoryGirl.create(:secretary)
    end
  end

  def login_student
    @student = 1
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      @student = FactoryGirl.create(:student)
      sign_in @student
    end
    return @student
  end
end
