# frozen_string_literal: true

# Authorization for user
class OAuth < ApplicationRecord
  belongs_to :user

  validates_presence_of :uid, :provider, :token
  validates_uniqueness_of :uid, scope: :provider
  validates :provider, inclusion: { in: %w[github facebook google] }
end
