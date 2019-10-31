# frozen_string_literal: true

# User devise
module User::DeviseAndAuth
  extend ActiveSupport::Concern
  include Devise::Models::Registerable
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
    scope :where_by_auth, lambda { |auth|
      with_auth.merge(OAuth.where(provider: auth.provider, uid: auth.uid))
    }
  end

  # :nodoc:
  module ClassMethods
    # Used at #build_resource at #Devise::RegistrationsController to create model from session
    def new_with_session(params, session)
      model_name = name.downcase
      session_model_data = session["devise.#{model_name}_attributes"]
      # merge は重複時, 引数の方を優先する
      if session_model_data.present?
        new(session_model_data.merge(params))
      else
        new(params)
      end
    end
  end
end
