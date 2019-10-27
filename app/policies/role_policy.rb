# frozen_string_literal: true

# Policy for access Role
class RolePolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope.all
    end

    def resolve_admin
      scope.all if user.master?
    end
  end
end
