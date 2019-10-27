# frozen_string_literal: true

# Ability of Role
# Not used now
class Ability < ApplicationRecord
  has_many :role_ability
  has_many :roles, through: :role_ability
end
