require "spec_helper"

describe AdvisesController do
  context "when routing" do

    it "routes to #index" do
      expect(get("/advises")).to route_to("advises#index")
    end

    it "routes to #new" do
      expect(get("/advises/new")).to route_to("advises#new")
    end

    it "routes to #show" do
      expect(get("/advises/1")).to route_to("advises#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/advises/1/edit")).to route_to("advises#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/advises")).to route_to("advises#create")
    end

    it "routes to #update" do
      expect(put("/advises/1")).to route_to("advises#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/advises/1")).to route_to("advises#destroy", :id => "1")
    end

  end
end
