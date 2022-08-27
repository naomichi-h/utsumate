# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it 'can change account data' do
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_button '変更'

    expect(page).to have_content 'アカウント情報を変更しました。'
  end

  it 'can withdrawal' do
    click_link 'アカウント削除'

    page.accept_confirm

    expect(page).to have_content 'アカウントを削除しました。'
  end
end
