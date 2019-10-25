# frozen_string_literal: true

# omniauth params
class AuthenticationMaker
  include Service

  def initialize(_user, _session)
    @model = model.to_s.constantize
    @auth = auth
  end

  def run
    needed = column_needed_by_model @model
    data = get_data_with_auth(@auth)
    if needed.blank?
      nil
    else
      get_hash_with_keys needed, data
    end
  end
end
