# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'test@test.com' }
    password { 'password' }
  end
end
