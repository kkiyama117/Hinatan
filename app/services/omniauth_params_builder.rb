# frozen_string_literal: true

# omniauth params
class OmniauthParamsBuilder
  include Service

  def initialize(model: nil, auth:)
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

  def get_hash_with_keys(keys, data)
    result = {}
    keys.each do |key|
      result.update(data.slice(key))
    end
    result
  end

  def column_needed_by_model(model)
    if model == User
      %i[first_name last_name email]
      # %i[name email password]
    elsif model == OAuth
      %i[provider uid token]
    else
      raise ValueError('error')
    end
  end

  private

  def get_data_with_auth(auth)
    send(('get_data_with_' + auth.fetch('provider').to_s).to_sym, auth)
  end

  def get_data_with_facebook(auth)
    { first_name: auth['info']['name'],
      last_name: auth['info']['name'],
      email: auth['info']['email'],
      provider: auth['provider'],
      uid: auth['uid'],
      token: auth['credentials']['token'] }
  end

  def get_data_with_google(auth)
    { first_name: auth['info']['name'],
      last_name: auth['info']['name'],
      email: auth['info']['email'],
      provider: auth['provider'],
      uid: auth['uid'],
      token: auth['credentials']['token'] }
  end
end
