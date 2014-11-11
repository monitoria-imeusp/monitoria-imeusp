require 'spec_helper'

describe "assistant_evaluations/edit" do
  before(:each) do
    @assistant_evaluation = assign(:assistant_evaluation, stub_model(AssistantEvaluation,
      :index_for_student => "MyString",
      :new => "MyString",
      :edit => "MyString",
      :create => "MyString",
      :update => "MyString",
      :destroy => "MyString"
    ))
  end

  it "renders the edit assistant_evaluation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", assistant_evaluation_path(@assistant_evaluation), "post" do
      assert_select "input#assistant_evaluation_index_for_student[name=?]", "assistant_evaluation[index_for_student]"
      assert_select "input#assistant_evaluation_new[name=?]", "assistant_evaluation[new]"
      assert_select "input#assistant_evaluation_edit[name=?]", "assistant_evaluation[edit]"
      assert_select "input#assistant_evaluation_create[name=?]", "assistant_evaluation[create]"
      assert_select "input#assistant_evaluation_update[name=?]", "assistant_evaluation[update]"
      assert_select "input#assistant_evaluation_destroy[name=?]", "assistant_evaluation[destroy]"
    end
  end
end
