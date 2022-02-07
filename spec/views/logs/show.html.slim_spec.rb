require 'rails_helper'

RSpec.describe "logs/show", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!(
      user_id: "",
      sleep: 2,
      meal: false,
      medicine: false,
      bathe: "Bathe",
      go_out: "Go Out",
      memo: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Bathe/)
    expect(rendered).to match(/Go Out/)
    expect(rendered).to match(/MyText/)
  end
end
