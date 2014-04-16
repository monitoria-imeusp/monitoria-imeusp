require 'spec_helper'

describe "RequestForTeachingAssistants" do
  describe "GET /request_for_teaching_assistants" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get request_for_teaching_assistants_path
      response.status.should be(200)
    end
  end
end
