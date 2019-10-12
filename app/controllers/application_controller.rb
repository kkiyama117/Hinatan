# frozen_string_literal: true

# responders (flash cache etc)
require 'application_responder'

# Base Controller
class ApplicationController < ActionController::Base
  # responders (flash cache etc)
  self.responder = ApplicationResponder
  respond_to :html

  before_action :store_user_location!, if: :storable_location?

  # For pundit()
  include Pundit
  # Add `mobile?` function
  include MobileCheck
  # CSRF
  protect_from_forgery with: :exception

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
