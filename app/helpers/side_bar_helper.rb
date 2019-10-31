# frozen_string_literal: true

# Menu
module SideBarHelper
  def current_user_name
    current_user.try(:first_name) || 'USER'
  end
end
