require 'rails_helper'

RSpec.describe "forests/show", type: :view do
  before(:each) do
    @forest = assign(:forest, Forest.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
