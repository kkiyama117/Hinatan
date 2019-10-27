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
    can?
  end

  def show?
    can?
  end

  def create?
    can?
  end

  def new?
    create?
  end

  def update?
    can?
  end

  def edit?
    update?
  end

  def destroy?
    can?
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
      # scope.where(owner: user)
      if @user.master?
        scope.all
      elsif @user.admin?
        scope.all
      end
    end
  end

  private

  def can?(ability: nil)
    User.with_abilities.merge(Ability.where(name: "#{@record.class.to_s.upcase}_#{ability}")).present? ||
        @user.master? || @user.admin?
  end
end
