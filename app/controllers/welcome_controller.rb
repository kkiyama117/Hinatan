# frozen_string_literal: true

# Index home page controller
class WelcomeController < ApplicationController
  skip_policy_scope
  def index; end
end
