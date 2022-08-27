# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :system do
  let(:user) { FactoryBot.build(:user) }

  before do
    visit new_user_registration_path
  end

  it 'can sign up' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password

    click_button '登録する'

    fill_in 'user[name]', with: user.name

    expect(page).to have_content 'アカウント登録が完了しました'
  end
end
