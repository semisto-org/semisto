require 'rails_helper'

RSpec.describe "forests/new", type: :view do
  before(:each) do
    assign(:forest, Forest.new(
      name: "MyString"
    ))
  end

  it "renders new forest form" do
    render

    assert_select "form[action=?][method=?]", forests_path, "post" do

      assert_select "input[name=?]", "forest[name]"
    end
  end
end
