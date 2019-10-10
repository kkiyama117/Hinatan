# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with correct data' do
    expect(create(:user)).to be_valid
  end

  it 'メールアドレスがなければ登録できない' do
    expect(build(:user, email: '')).to_not be_valid
  end

  it 'パスワードがなければ登録できない' do
    expect(build(:user, password: '')).to_not be_valid
  end

  it 'password_confirmationとpasswordが異なる場合保存できない' do
    expect(build(:user, password: 'password',
                        password_confirmation: 'passward')).to_not be_valid
  end
end
