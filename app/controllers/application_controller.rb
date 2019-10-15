# frozen_string_literal: true

# responders (flash cache etc)
require 'application_responder'

# Base Controller
class ApplicationController < ActionController::Base
  # responders (flash cache etc)
  self.responder = ApplicationResponder
  respond_to :html

  # base for all Controllers in this app
  include ApplicationBaseModule
end
