# frozen_string_literal: true

# Check client browser
module MobileCheck
  extend ActiveSupport::Concern

  # @return [Object]
  def mobile?
    request.user_agent =~ /iPhone|iPad|Android/
  end
end
