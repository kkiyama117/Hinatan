# frozen_string_literal: true

# app/models/form/base.rb
class Form::Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

end
