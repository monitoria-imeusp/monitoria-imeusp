require "spec_helper"

describe AssistantEvaluationsController do
  describe "routing" do

    it "routes to #index_for_student" do
      get("/assistant_evaluations/for_student/1").should route_to("assistant_evaluations#index_for_student", :student_id => "1")
    end

    it "routes to #new" do
      get("/assistant_evaluations/1/new").should route_to("assistant_evaluations#new", :assistant_role_id => "1")
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

  end
end
