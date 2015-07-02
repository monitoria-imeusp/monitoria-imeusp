require "spec_helper"

describe AssistantEvaluationsController do
  context "when routing" do

    it "routes to #index_for_student" do
      expect(get("/assistant_evaluations/for_student/1")).to route_to("assistant_evaluations#index_for_student", :student_id => "1")
    end

    it "routes to #new" do
      expect(get("/assistant_evaluations/1/new")).to route_to("assistant_evaluations#new", :assistant_role_id => "1")
    end

    it "routes to #edit" do
      expect(get("/assistant_evaluations/1/edit")).to route_to("assistant_evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/assistant_evaluations")).to route_to("assistant_evaluations#create")
    end

    it "routes to #update" do
      expect(put("/assistant_evaluations/1")).to route_to("assistant_evaluations#update", :id => "1")
    end

  end
end
