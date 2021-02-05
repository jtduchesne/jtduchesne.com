class Project < ApplicationRecord
  # Attributes: name, description, live_url, github_url
  
  has_one_attached :image
  
  validates_presence_of :name
  validate :description_present_in_both_languages
  
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
  
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  
  TAGS_DELIMITER = ",".freeze
  def tag_names
    tags&.map(&:name).join(TAGS_DELIMITER) || ""
  end
  def tag_names=(value)
    tags.clear
    value.split(TAGS_DELIMITER)&.each do |tag_name|
      self.tags << Tag.find_or_create_by(name: tag_name.strip)
    end
  end
  
  validates_presence_of :live_url, unless: :github_url?
  validates_presence_of :github_url, unless: :live_url?
  
private
  def description_present_in_both_languages
    errors.add(:description_fr, :blank) if description[:fr].blank?
    errors.add(:description_en, :blank) if description[:en].blank?
  end
end
