# frozen_string_literal: true

# Menu
module SideBarHelper
  def sign_in_or_out_tag(html_option = nil, &block)
    if user_signed_in?
      link_to destroy_session_path(User), method: :delete, **html_option, &block
    else
      link_to new_session_path(User), html_option, &block
    end
  end

  def sign_tag_string
    if user_signed_in?
      I18n.t('devise.shared.links.sign_out')
    else
      I18n.t('devise.shared.links.sign_in')
    end
  end
end
