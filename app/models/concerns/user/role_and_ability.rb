# frozen_string_literal: true

# Preparation for Pundit
# Need db:seed or Create
module User::RoleAndAbility
  extend ActiveSupport::Concern
  included do
    # Roles
    has_many :user_roles, dependent: :destroy
    has_many :roles, through: :user_roles
    scope :masters, -> { joins(child: [roles: :abilities]).merge(Ability.find_by(name: 'MASTER')) }
  end
  # check master, admin or not
  def master?
    User.masters.ids.include? id
  end

  # get abilities
  def abilities; end
end
