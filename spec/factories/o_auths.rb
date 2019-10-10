# frozen_string_literal: true

FactoryBot.define do
  factory :o_auth do
    uid { 'MyString' }
    provider { 'TestService' }
  end
end
