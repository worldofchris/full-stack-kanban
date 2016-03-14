require 'rails_helper'

RSpec.describe "workers/edit", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!(
      :name => "MyString",
      :duration => 1
    ))
  end

  it "renders the edit worker form" do
    render

    assert_select "form[action=?][method=?]", worker_path(@worker), "post" do

      assert_select "input#worker_name[name=?]", "worker[name]"

      assert_select "input#worker_duration[name=?]", "worker[duration]"
    end
  end
end
