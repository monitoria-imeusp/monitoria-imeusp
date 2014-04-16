require "spec_helper"

describe RequestForTeachingAssistantsController do
  describe "routing" do

    it "routes to #index" do
      get("/request_for_teaching_assistants").should route_to("request_for_teaching_assistants#index")
    end

    it "routes to #new" do
      get("/request_for_teaching_assistants/new").should route_to("request_for_teaching_assistants#new")
    end

    it "routes to #show" do
      get("/request_for_teaching_assistants/1").should route_to("request_for_teaching_assistants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/request_for_teaching_assistants/1/edit").should route_to("request_for_teaching_assistants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/request_for_teaching_assistants").should route_to("request_for_teaching_assistants#create")
    end

    it "routes to #update" do
      put("/request_for_teaching_assistants/1").should route_to("request_for_teaching_assistants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/request_for_teaching_assistants/1").should route_to("request_for_teaching_assistants#destroy", :id => "1")
    end

  end
end
