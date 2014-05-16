module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_professor
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:professor]
      sign_in FactoryGirl.create(:professor)
    end
  end

  def login_secretary
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:secretary]
      sign_in FactoryGirl.create(:secretary)
    end
  end
end
