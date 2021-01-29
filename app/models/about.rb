class About < ApplicationRecord
  # Attributes: published_on
  
  has_one_attached :image
  
  has_rich_text :fr
  has_rich_text :en
  validates_presence_of :fr, :en
  
  default_scope -> { order(:published_on, :created_at) }
  
  scope :draft,     -> { where(published_on: nil) }
  scope :published, -> { where("published_on <= current_date") }
  
  def self.current
    published.last
  end
  
  def from
    published_on_in_database
  end
  def to
    self.class.where("published_on > ?", from).first.try(:published_on) unless from.nil?
  end
  
  def published
    published_on?
  end
  def published=(value)
    self.published_on = Date.today if value && draft?
  end
  
  def draft?
    !published_on?
  end
  def published?
    published_on?
  end
  
  def current?
    published? && !past?
  end
  def past?
    self.class.published.where("published_on > ?", from).exists?
  end
end
