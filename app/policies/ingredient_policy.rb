# frozen_string_literal: true

class IngredientPolicy < ApplicationPolicy
  # :nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
