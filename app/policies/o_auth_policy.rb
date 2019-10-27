# frozen_string_literal: true

class OAuthPolicy < ApplicationPolicy
  # :nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
