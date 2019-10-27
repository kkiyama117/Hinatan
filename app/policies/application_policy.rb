# frozen_string_literal: true

# Default Access policy
class ApplicationPolicy
  attr_reader :user, :record

  # #current_user is inserted into @user
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    # #Admin::ApplicationController
    # https://administrate-prototype.herokuapp.com/authorization
    def resolve_admin
      # scope.where(owner: user) || @user.master?
      @user.master?
    end
  end

  private

  def can?(_ability)
    (@user.abilities.include?(@record).class.to_s.underscore && user.abilities) || @user.master?
  end
end
