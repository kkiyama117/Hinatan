# frozen_string_literal: true

# Policy for access Role
class RolePolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope.all
    end

    def resolve_admin
      return scope.all if user.master?

      scope.where('id<0')
    end
  end
end
