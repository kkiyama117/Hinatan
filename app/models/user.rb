# frozen_string_literal: true

# User Base Model
class User < ApplicationRecord
  include User::DeviseAndAuth
  include User::RoleAndAbility

  # name validates
  validates :first_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
end
