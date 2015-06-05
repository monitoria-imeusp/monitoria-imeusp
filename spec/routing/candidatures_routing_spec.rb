require "spec_helper"

describe CandidaturesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/candidatures")).to route_to("candidatures#index")
    end

    it "routes to #new" do
      expect(get("/candidatures/1/new")).to route_to("candidatures#new", :semester_id => "1")
    end

    it "routes to #show" do
      expect(get("/candidatures/1")).to route_to("candidatures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/candidatures/1/edit")).to route_to("candidatures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/candidatures")).to route_to("candidatures#create")
    end

    it "routes to #update" do
      expect(put("/candidatures/1")).to route_to("candidatures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/candidatures/1")).to route_to("candidatures#destroy", :id => "1")
    end

  end
end
