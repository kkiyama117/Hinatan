# frozen_string_literal: true

# Check client browser
module ApplicationBaseModule
  extend ActiveSupport::Concern
  # For pundit()
  include Pundit
  # Add `mobile?` function
  include MobileCheck

  included do
    skip_before_action :verify_authenticity_token
    before_action :store_user_location!, if: :storable_location?
    # after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index

    # CSRF
    # default -> on
    protect_from_forgery prepend: true, with: :exception

    # Rescue from Pundit error
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def current_user
    UserDecorator.decorate(super) if super.present?
  end

  private

  # Catch Pundit exception and redirect
  def user_not_authorized
    flash[:alert] = t('pundit.failures.action_not_allowed')
    redirect_to(request.referrer || root_path)
  end

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
