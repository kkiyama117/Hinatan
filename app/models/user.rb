# frozen_string_literal: true

# User Base Model
class User < ApplicationRecord
  # Authentication
  include User::DeviseAndAuth
  # Authorization
  include User::RoleAndAbility

  # name validates
  validates :first_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
end
