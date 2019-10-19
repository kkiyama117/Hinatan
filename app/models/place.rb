# frozen_string_literal: true

# Place can mount under each place
class Place < ApplicationRecord
  has_many :children, class_name: 'Place', foreign_key: :parent_id, dependent: :delete_all
  belongs_to :parent, class_name: 'Place', optional: true, foreign_key: :parent_id
end
