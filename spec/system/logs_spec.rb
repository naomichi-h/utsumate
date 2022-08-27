# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logs', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:log1) { FactoryBot.create(:log) }
  let(:log2) { FactoryBot.build(:log, date: '2022-08-02') }

  before do
    sign_in user
  end

  it 'creates new log' do
    visit new_log_path
    fill_in 'log[date]', with: log2.date
    find("option[value='#{log2.sleep}']").select_option
    choose 'log_medicine_true'
    choose 'log_meal_true'
    choose 'log_bathe_voluntary'
    choose 'log_go_out_alone'
    fill_in 'log[memo]', with: log2.memo
    click_button '記録作成'

    expect(page).to have_content '記録を作成しました！'
  end

  it 'edits log' do
    visit edit_log_path(log1.id)
    fill_in 'log[date]', with: log2.date
    find("option[value='#{log2.sleep}']").select_option
    choose 'log_medicine_false'
    choose 'log_meal_false'
    choose 'log_bathe_prompted'
    choose 'log_go_out_with_someone'
    fill_in 'log[memo]', with: log2.memo
    click_button '内容変更'

    expect(page).to have_content '記録を編集しました！'
  end

  it 'destroys log' do
    visit log_path(log1.id)
    click_link '削除する'

    page.accept_confirm

    expect(page).to have_content '記録を削除しました！'
  end
end
