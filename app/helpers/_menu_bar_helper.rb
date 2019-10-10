# frozen_string_literal: true

# Menu
module MenuBarHelper
  # for header
  def user_menu
    used_methods = %i[edit_profile_link logout_link]
    case controller_name
    when 'registrations'
      used_methods.delete(:edit_profile_link)
    else
      used_methods = used_methods
    end
    create_menu(used_methods)
  end

  def no_user_menu
    used_methods = %i[login_link sign_up_link recover_password_link]
    case controller_name
    when 'sessions'
      used_methods.delete(:login_link)
    when 'registrations'
      used_methods.delete(:sign_up_link)
      used_methods.delete(:recover_password_link)
    when 'passwords'
      used_methods.delete(:recover_password_link)
    else
      used_methods = used_methods
    end
    create_menu(used_methods)
  end

  def omniauth_tag(signed_in:)
    str = if signed_in
            'devise.shared.links.link_to_provider'
          else
            'devise.shared.links.sign_in_with_provider'
          end
    User.omniauth_providers.map do |provider|
      tag.li do
        link_to t(str, provider: OmniAuth::Utils.camelize(provider)),
                omniauth_authorize_path(User, provider)
      end
    end.join.html_safe
  end

  private

  # utils
  def create_menu(methods)
    methods.map do |method|
      tag.li do
        send(method)
      end
    end.join.html_safe
  end

  # each links
  def login_link
    link_to(I18n.t('devise.shared.links.sign_in'), new_session_path(User))
  end

  def sign_up_link
    link_to(I18n.t('devise.shared.links.sign_up'), new_registration_path(User))
  end

  def recover_password_link
    link_to I18n.t('devise.shared.links.forgot_your_password'), new_password_path(User)
  end

  def confirm_check_link
    link_to I18n.t('devise.shared.links.didn_t_receive_confirmation_instructions'), new_confirmation_path(User)
  end

  def edit_profile_link
    link_to I18n.t('devise.shared.links.edit_profile'), edit_registration_path(User)
  end

  def logout_link
    link_to I18n.t('devise.shared.links.sign_out'), destroy_session_path(User), method: :delete
  end
end
