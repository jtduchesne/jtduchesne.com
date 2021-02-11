class Post < ApplicationRecord
  # Attributes: language, title, preview, published_on
  
  enum language: {french: "FR", english: "EN"}
  
  validates_presence_of :title, :preview
  validates_length_of :preview, maximum: 500
  
  default_scope -> { order(:published_on, :created_at) }
  
  scope :draft,     -> { where(published_on: nil) }
  scope :published, -> { where("published_on <= current_date") }
  
  def draft?
    !published_on?
  end
  def published?
    published_on? && published_on <= Date.today
  end
end
