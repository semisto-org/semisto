require 'rails_helper'

RSpec.describe "forests/index", type: :view do
  before(:each) do
    assign(:forests, [
      Forest.create!(
        name: "Name"
      ),
      Forest.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of forests" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
