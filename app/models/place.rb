# frozen_string_literal: true

# Place can mount under each place
class Place < ApplicationRecord
  has_many :children, class_name: 'Place'
  belongs_to :parent, class_name: 'Place', optional: true, foreign_key: 'parent_id'
end
