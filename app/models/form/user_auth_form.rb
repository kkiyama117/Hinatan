# frozen_string_literal: true

# Form for Recipe and Ingredient
class Form::UserAuthForm < Form::Base
  def initialize(attributes = {})
    super attributes
    self.user = user
  end

  concerning :UserBuilder do
    attr_accessor :users

    def user
      @user ||= User.new
    end

    def user_attributes=(attributes)
      @user_attributes = User.new attributes
    end
  end

  concerning :OAuthBuilder do
    attr_accessor :o_auths

    def o_auth
      @o_auth ||= OAuth.new
    end

    def o_auth_attributes=(attributes)
      @o_auth_attributes = OAuth.new attributes
    end
  end

  def save
    return false if invalid?

    @user.o_auths << @o_auth
    @user.save
  end

  private

  def invalid?
    super && @o_auth.valid? && @user.valid?
  end
end
