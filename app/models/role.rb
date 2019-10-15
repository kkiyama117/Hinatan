# frozen_string_literal: true

# Role of Users
class Role < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 },
                   uniqueness: { case_sensitive: false }
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
end
