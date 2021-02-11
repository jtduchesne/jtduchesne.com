class Project < ApplicationRecord
  # Attributes: name, description, live_url, github_url
  
  has_one_attached :image
  
  validates_presence_of :name
  validate :description_present_in_both_languages
  validates :slug, presence: true, uniqueness: true, format: /\A[^\s\\\/@"']+\z/
  
  def to_param
    slug
  end
  
  serialize :description, JSON
  def description
    super.with_indifferent_access rescue {}
  end
  def description=(value)
    if value.is_a?(Hash)
      super(value.symbolize_keys.slice(*I18n.available_locales))
    else
      super({ fr: value.to_s, en: value.to_s })
    end
  end
  
  def description_fr; description[:fr]; end
  def description_en; description[:en]; end
  
  include Taggable
  
  validates_presence_of :live_url, unless: :github_url?
  validates_presence_of :github_url, unless: :live_url?
  
private
  def description_present_in_both_languages
    errors.add(:description_fr, :blank) if description[:fr].blank?
    errors.add(:description_en, :blank) if description[:en].blank?
  end
end
