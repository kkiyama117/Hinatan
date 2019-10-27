# frozen_string_literal: true

# :nodoc:
class IngredientPolicy < ApplicationPolicy

  def index?
    true
  end

  # :nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
