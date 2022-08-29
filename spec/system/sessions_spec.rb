# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit user_session_path
  end

  it 'can log in' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'

    expect(page).to have_content 'ログインしました'
  end

  it 'can log out' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'

    find('.navbar-burger').click

    click_link 'ログアウト'

    expect(page).to have_content 'ログアウトしました'
  end
end
