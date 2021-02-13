class Post < ApplicationRecord
  # Attributes: language, title, preview, published_on
  
  include Sluggable
  
  enum language: {french: "FR", english: "EN"}
  
  scope :language, ->(locale) { where(language: locale.to_s.upcase) }
  
  def locale
    language_before_type_cast.downcase.to_sym
  end
  
  has_one :translation
  has_one :translated, -> { published }, through: :translation,
                       class_name: "Post", foreign_key: "translated_id"
  
  def translated=(value)
    if value.present?
      value = self.class.find(value) unless value.is_a?(self.class)
      super(value)
      value.translated = self unless value.translated.present?
    end
  end
  
  scope :untranslated, -> { left_outer_joins(:translation).where(translation: {translated: nil}) }
  
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
  
  include Taggable
  
  has_rich_text :content
  validates_presence_of :content
end
