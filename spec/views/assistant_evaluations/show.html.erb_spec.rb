require 'spec_helper'

describe "assistant_evaluations/show" do
  before(:each) do
    @assistant_evaluation = assign(:assistant_evaluation, stub_model(AssistantEvaluation,
      :index_for_student => "Index For Student",
      :new => "New",
      :edit => "Edit",
      :create => "Create",
      :update => "Update",
      :destroy => "Destroy"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Index For Student/)
    rendered.should match(/New/)
    rendered.should match(/Edit/)
    rendered.should match(/Create/)
    rendered.should match(/Update/)
    rendered.should match(/Destroy/)
  end
end
