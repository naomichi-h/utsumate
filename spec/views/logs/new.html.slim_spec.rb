require 'rails_helper'

RSpec.describe "logs/new", type: :view do
  before(:each) do
    assign(:log, Log.new(
      user_id: "",
      sleep: 1,
      meal: false,
      medicine: false,
      bathe: "MyString",
      go_out: "MyString",
      memo: "MyText"
    ))
  end

  it "renders new log form" do
    render

    assert_select "form[action=?][method=?]", logs_path, "post" do

      assert_select "input[name=?]", "log[user_id]"

      assert_select "input[name=?]", "log[sleep]"

      assert_select "input[name=?]", "log[meal]"

      assert_select "input[name=?]", "log[medicine]"

      assert_select "input[name=?]", "log[bathe]"

      assert_select "input[name=?]", "log[go_out]"

      assert_select "textarea[name=?]", "log[memo]"
    end
  end
end
