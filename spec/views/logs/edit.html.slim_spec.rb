require 'rails_helper'

RSpec.describe "logs/edit", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!(
      user_id: "",
      sleep: 1,
      meal: false,
      medicine: false,
      bathe: "MyString",
      go_out: "MyString",
      memo: "MyText"
    ))
  end

  it "renders the edit log form" do
    render

    assert_select "form[action=?][method=?]", log_path(@log), "post" do

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
