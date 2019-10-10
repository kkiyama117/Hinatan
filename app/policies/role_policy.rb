# frozen_string_literal: true

# Policy for access Role
class RolePolicy < ApplicationPolicy
  def create?
    user.roles.find_by(name: 'ADMIN').present?
  end

  def update?
    user.roles.find_by(name: 'ADMIN').present?
  end
  # Scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
