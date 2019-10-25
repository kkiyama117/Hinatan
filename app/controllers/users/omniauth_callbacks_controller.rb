# frozen_string_literal: true

# Controller for authentication
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include ApplicationBaseModule

  protect_from_forgery except: %i[facebook google passthru]
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def facebook
    if request.env['omniauth.auth'].info.email.blank?
      redirect_to '/users/auth/facebook?auth_type=rerequest&scope=email'
      return # be sure to include an return if there is code after this otherwise it will be executed
    end
    base_action
  end

  def google
    base_action
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  # @return [Object]
  def base_action
    # Oauth の仕様としてCallbackが帰る
    auth = request.env['omniauth.auth']
    user = User.where_by_auth(auth).first
    if user_signed_in?
      if user.present?
        signed_in_with_auth_action user: user, auth: auth
      else
        create_new_oauth_link auth: auth
      end
    elsif user.present?
      sign_in_with_auth(user: user, auth: auth)
    else
      redirect_to_register auth: auth
    end
  end

  def signed_in_with_auth_action(user:, auth:)
    reason = if user == current_user
               t('devise.failure.already_authenticated')
             else
               t('errors.messages.already_confirmed')
             end
    if is_navigational_format?
      set_flash_message(:notice, :failure, kind: auth.provider,
                                           reason: reason)
    end
    redirect_to user_root_path
  end

  def create_new_oauth_link(auth:)
    auth_data = OmniauthParamsBuilder.new(model: 'OAuth',
                                          auth: auth).run
    current_user.o_auths.create(auth_data)
    if is_navigational_format?
      set_flash_message(:notice, :success,
                        kind: auth.provider)
    end
    redirect_to user_root_path
  end

  def sign_in_with_auth(user:, auth:)
    # sign in as OAuth User
    if is_navigational_format?
      set_flash_message(:notice, :success,
                        kind: auth.provider)
    end
    sign_in_and_redirect user, event: :authentication
  end

  def redirect_to_register(auth:)
    # Register new user with OAuth
    user_data_from_auth = OmniauthParamsBuilder.new(model: User,
                                                    auth: auth).run
    session['devise.user_attributes'] = user_data_from_auth
    auth_data = OmniauthParamsBuilder.new(model: 'OAuth',
                                          auth: auth).run
    session['devise.o_auth_attributes'] = auth_data
    redirect_to new_user_registration_path
  end
end
