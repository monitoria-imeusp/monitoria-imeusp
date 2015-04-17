require 'spec_helper'

describe "Secretaries" do
  describe "GET /secretaries" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get secretaries_path
      should redirect_to('/403')
    end
  end
end
