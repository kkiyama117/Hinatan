# frozen_string_literal: true

# User Base Model
class User < ApplicationRecord
  include User::DeviseAndAuth

  # name validates
  validates :first_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }
  validates :last_name, presence: true, length: { maximum: 10 }, uniqueness: { case_sensitive: false }

  # Roles
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
end
