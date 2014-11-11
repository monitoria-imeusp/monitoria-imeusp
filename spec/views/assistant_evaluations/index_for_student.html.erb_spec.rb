require 'spec_helper'

describe "assistant_evaluations/index" do
  before(:each) do
    assign(:assistant_evaluations, [
      stub_model(AssistantEvaluation,
        :index_for_student => "Index For Student",
        :new => "New",
        :edit => "Edit",
        :create => "Create",
        :update => "Update",
        :destroy => "Destroy"
      ),
      stub_model(AssistantEvaluation,
        :index_for_student => "Index For Student",
        :new => "New",
        :edit => "Edit",
        :create => "Create",
        :update => "Update",
        :destroy => "Destroy"
      )
    ])
  end

  it "renders a list of assistant_evaluations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index For Student".to_s, :count => 2
    assert_select "tr>td", :text => "New".to_s, :count => 2
    assert_select "tr>td", :text => "Edit".to_s, :count => 2
    assert_select "tr>td", :text => "Create".to_s, :count => 2
    assert_select "tr>td", :text => "Update".to_s, :count => 2
    assert_select "tr>td", :text => "Destroy".to_s, :count => 2
  end
end
