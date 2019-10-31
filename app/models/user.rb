# frozen_string_literal: true

# User Base Model
class User < ApplicationRecord
  # Authentication
  # Devise, #OAuth model
  include User::DeviseAndAuth
  # Authorization
  # Pundit, #Role and #Ability model
  include User::RoleAndAbility

  # name validates
  validates :first_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
end
