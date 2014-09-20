require "spec_helper"

describe CandidaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/candidatures").should route_to("candidatures#index")
    end

    it "routes to #new" do
      get("/candidatures/1/new").should route_to("candidatures#new", :id => "1")
    end

    it "routes to #show" do
      get("/candidatures/1").should route_to("candidatures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/candidatures/1/edit").should route_to("candidatures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/candidatures").should route_to("candidatures#create")
    end

    it "routes to #update" do
      put("/candidatures/1").should route_to("candidatures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/candidatures/1").should route_to("candidatures#destroy", :id => "1")
    end

  end
end
