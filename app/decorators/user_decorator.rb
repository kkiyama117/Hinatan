# frozen_string_literal: true

# format User attributes
class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def omniauth_tag_string(sign_in:)
    str = if sign_in
            'devise.shared.links.link_to_provider'
          else
            'devise.shared.links.sign_in_with_provider'
          end
    t(str, provider: OmniAuth::Utils.camelize(provider))
  end
end
