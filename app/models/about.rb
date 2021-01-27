class About < ApplicationRecord
  has_rich_text :fr
  has_rich_text :en
  validates_presence_of :fr, :en
  
  default_scope -> { order(:created_at) }
end
