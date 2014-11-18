require "spec_helper"

describe AdvisesController do
  describe "routing" do

    it "routes to #index" do
      get("/advises").should route_to("advises#index")
    end

    it "routes to #new" do
      get("/advises/new").should route_to("advises#new")
    end

    it "routes to #show" do
      get("/advises/1").should route_to("advises#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advises/1/edit").should route_to("advises#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advises").should route_to("advises#create")
    end

    it "routes to #update" do
      put("/advises/1").should route_to("advises#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advises/1").should route_to("advises#destroy", :id => "1")
    end

  end
end
