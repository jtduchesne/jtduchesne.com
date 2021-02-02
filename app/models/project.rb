class Project < ApplicationRecord
  # Attributes: name, description, live_url, github_url
  
  validates_presence_of :name, :description
  validates_presence_of :live_url, unless: :github_url?
  validates_presence_of :github_url, unless: :live_url?
  
  has_one_attached :image
end
