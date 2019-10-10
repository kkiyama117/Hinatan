# frozen_string_literal: true

# User devise
module User::DeviseAndAuth
  extend ActiveSupport::Concern
  included do
    # Include default devise modules. Others available are:
    # :lockable, :timeoutable, :trackable and :omniauthable
    devise :confirmable, :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[
             facebook google
           ]

    # auth model
    has_many :o_auths, dependent: :delete_all
    accepts_nested_attributes_for :o_auths, allow_destroy: true, reject_if: :all_blank

    scope :with_auth, -> { joins(:o_auths) }
    scope :find_by_auth, lambda { |auth|
      with_auth.merge(OAuth.where(provider: auth.provider, uid: auth.uid))
    }
  end
end
