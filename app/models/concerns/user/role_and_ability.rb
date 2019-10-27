# frozen_string_literal: true

# Preparation for Pundit
# Need db:seed or Create
module User::RoleAndAbility
  extend ActiveSupport::Concern
  included do
    # Roles
    has_many :user_roles, dependent: :destroy
    has_many :roles, through: :user_roles
    scope :with_roles, -> { joins(:roles) }
    # Scope for abilities
    scope :with_abilities, -> { joins(roles: :abilities) }
    scope :masters, -> { with_abilities.merge(Ability.where(name: 'MASTER')) }
    scope :admins, -> { with_abilities.merge(Ability.where(name: 'ACCESS_ADMIN')) }
  end

  # check master, admin or not
  def master?
    User.masters.try(:ids).try(:include?, id)
  end

  # check access ability
  def admin?
    User.admins.try(:ids).try(:include?, id) || master?
  end
end
