# frozen_string_literal: true

# :nodoc:
class RoleAbility < ApplicationRecord
  belongs_to :role
  belongs_to :ability
end
