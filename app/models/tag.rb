class Tag < ApplicationRecord
  # Attributes: name
  
  validates :name, presence: true, uniqueness: true
  
  has_many :taggings
  has_many :posts,    through: :taggings, source: :taggable, source_type: 'Post'
  has_many :projects, through: :taggings, source: :taggable, source_type: 'Project'
end
