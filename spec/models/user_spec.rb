# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid_normal' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'is valid a password that has 6 characters' do
      user = FactoryBot.build(:user, password: '000001')
      expect(user).to be_valid
    end

    it 'is valid a password that has 20 characters' do
      user = FactoryBot.build(:user, password: '00000111112222233333')
      expect(user).to be_valid
    end
  end

  describe 'valid_error' do
    it 'is invalid without email address' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'is invalid with a duplicate email address' do
      FactoryBot.create(:user, email: 'tester@example.com')
      user = FactoryBot.build(:user, email: 'tester@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'is invalid without password' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'is invalid a password that has less than 5 characters' do
      user = FactoryBot.build(:user, password: '00000')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'is invalid a password that has more than 21 characters' do
      user = FactoryBot.build(:user, password: '000001111122222333334')
      user.valid?
      expect(user.errors[:password]).to include('は20文字以内で入力してください')
    end
  end
end
