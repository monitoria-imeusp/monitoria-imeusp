require "spec_helper"

describe SecretariesController do
  context "when routing" do

    it "routes to #index" do
      expect(get("/secretaries")).to route_to("secretaries#index")
    end

    it "routes to #new" do
      expect(get("/secretaries/new")).to route_to("secretaries#new")
    end

    it "routes to #show" do
      expect(get("/secretaries/1")).to route_to("secretaries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/secretaries/1/edit")).to route_to("secretaries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/secretaries")).to route_to("secretaries#create")
    end

    it "routes to #update" do
      expect(put("/secretaries/1")).to route_to("secretaries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/secretaries/1")).to route_to("secretaries#destroy", :id => "1")
    end

  end
end
