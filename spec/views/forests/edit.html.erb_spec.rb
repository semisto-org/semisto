require 'rails_helper'

RSpec.describe "forests/edit", type: :view do
  before(:each) do
    @forest = assign(:forest, Forest.create!(
      name: "MyString"
    ))
  end

  it "renders the edit forest form" do
    render

    assert_select "form[action=?][method=?]", forest_path(@forest), "post" do

      assert_select "input[name=?]", "forest[name]"
    end
  end
end
