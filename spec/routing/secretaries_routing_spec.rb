require "spec_helper"

describe SecretariesController do
  describe "routing" do

    it "routes to #index" do
      get("/secretaries").should route_to("secretaries#index")
    end

    it "routes to #new" do
      get("/secretaries/new").should route_to("secretaries#new")
    end

    it "routes to #show" do
      get("/secretaries/1").should route_to("secretaries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/secretaries/1/edit").should route_to("secretaries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/secretaries").should route_to("secretaries#create")
    end

    it "routes to #update" do
      put("/secretaries/1").should route_to("secretaries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/secretaries/1").should route_to("secretaries#destroy", :id => "1")
    end

  end
end
