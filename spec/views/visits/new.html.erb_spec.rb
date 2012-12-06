require 'spec_helper'

describe "visits/new.html.erb" do
  before(:each) do
    assign(:visit, stub_model(Visit,
      :item_id => "MyString",
      :title => "MyString",
      :visits => 1
    ).as_new_record)
  end

  it "renders new visit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => visits_path, :method => "post" do
      assert_select "input#visit_item_id", :name => "visit[item_id]"
      assert_select "input#visit_title", :name => "visit[title]"
      assert_select "input#visit_visits", :name => "visit[visits]"
    end
  end
end
