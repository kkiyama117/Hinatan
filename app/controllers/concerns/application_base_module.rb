# frozen_string_literal: true

# Check client browser
module ApplicationBaseModule
  extend ActiveSupport::Concern
  # For pundit()
  include Pundit
  # Add `mobile?` function
  include MobileCheck

  included do
    before_action :store_user_location!, if: :storable_location?

    # CSRF
    protect_from_forgery with: :exception
  end

  def current_user
    UserDecorator.decorate(super) if super.present?
  end

  private

  # devise methods
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  # ログアウトした時もフレンドリーフォワーディング
  def after_sign_out_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
