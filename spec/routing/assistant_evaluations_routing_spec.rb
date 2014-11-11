require "spec_helper"

describe AssistantEvaluationsController do
  describe "routing" do

    it "routes to #index" do
      get("/assistant_evaluations").should route_to("assistant_evaluations#index")
    end

    it "routes to #new" do
      get("/assistant_evaluations/new").should route_to("assistant_evaluations#new")
    end

    it "routes to #show" do
      get("/assistant_evaluations/1").should route_to("assistant_evaluations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/assistant_evaluations/1/edit").should route_to("assistant_evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/assistant_evaluations").should route_to("assistant_evaluations#create")
    end

    it "routes to #update" do
      put("/assistant_evaluations/1").should route_to("assistant_evaluations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/assistant_evaluations/1").should route_to("assistant_evaluations#destroy", :id => "1")
    end

  end
end
