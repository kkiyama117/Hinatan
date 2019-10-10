# frozen_string_literal: true

# index page for login user
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end
end
