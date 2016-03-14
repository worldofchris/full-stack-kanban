require 'rails_helper'

RSpec.describe "workers/index", type: :view do
  before(:each) do
    assign(:workers, [
      Worker.create!(
        :name => "Name",
        :duration => 1
      ),
      Worker.create!(
        :name => "Name",
        :duration => 1
      )
    ])
  end

  it "renders a list of workers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
