require "spec_helper"

describe RequestForTeachingAssistantsController do
  context "when routing" do

    it "routes to #index" do
      expect(get("/request_for_teaching_assistants")).to route_to("request_for_teaching_assistants#index")
    end

    it "routes to #new" do
      expect(get("/request_for_teaching_assistants/1/new")).to route_to("request_for_teaching_assistants#new", :semester_id => "1")
    end

    it "routes to #show" do
      expect(get("/request_for_teaching_assistants/1")).to route_to("request_for_teaching_assistants#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/request_for_teaching_assistants/1/edit")).to route_to("request_for_teaching_assistants#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/request_for_teaching_assistants")).to route_to("request_for_teaching_assistants#create")
    end

    it "routes to #update" do
      expect(put("/request_for_teaching_assistants/1")).to route_to("request_for_teaching_assistants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/request_for_teaching_assistants/1")).to route_to("request_for_teaching_assistants#destroy", :id => "1")
    end

  end
end
