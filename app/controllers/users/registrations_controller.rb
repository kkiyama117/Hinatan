# frozen_string_literal: true

# User Registration (User model create, update and delete)
class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationBaseModule

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |user|
      o_auth_data = session['devise.o_auth_attributes']
      # TODO(kkiyama117): Use UserForm Class
      user.o_auths << OAuth.new(o_auth_data) if o_auth_data.present?
      user
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session dataja..
  # def cancel
  #   super
  # end

  protected

  def build_resource(hash = {})
    self.resource = User.new_with_auth_session(hash, session)
  end

  # If you have extra params to permit, append them to the sanitizer.mail
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:
        [:first_name, :last_name, :email, o_auths_attributes: %i[id provider uid token]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys:
        [:first_name, :last_name, :email, o_auths_attributes: [:_destroy]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
