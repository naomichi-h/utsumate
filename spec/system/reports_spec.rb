require 'rails_helper'

RSpec.describe "Reports", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:log) { FactoryBot.create(:log, user: user) }

  before do
    sign_in user
    visit report_new_path
  end

  # headless_chromeでは印刷ダイアログが使用不可なためブラウザを立ち上げてテスト
  it 'creates report', headless: false do
    find("option[value='#{2022}']").select_option
    find("option[value='#{8}']").select_option
    click_button 'うつレポ表示'

    # spec/support/capybara.rbにてブラウザオプションに--kiosk-printingを設定しているため、
    # 印刷ダイアログ表示後、自動で保存ボタンが押下される
    click_button '印刷する'

    expect(page).to have_content '睡眠時間'
    expect(page).to have_content '総合カレンダー'
    expect(page).to have_content '食事'
    expect(page).to have_content '入浴'
    expect(page).to have_content '外出'
    expect(page).to have_content 'メモ'
    expect(page).to have_content '印刷する'

  end

  it 'do not creates report if there is no log' do
    find("option[value='#{2022}']").select_option
    find("option[value='#{7}']").select_option
    click_button 'うつレポ表示'

    expect(page).to have_content '記録がまだ一件も無いためうつレポを表示できません'
  end

end
