module Taggable
  extend ActiveSupport::Concern
  
  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end
  
  TAGS_DELIMITER = ",".freeze
  
  def tag_names
    tags&.map(&:name).join(TAGS_DELIMITER) || "".freeze
  end
  def tag_names=(value)
    tags.clear
    value.split(TAGS_DELIMITER)&.each do |tag_name|
      self.tags << Tag.find_or_create_by(name: tag_name.strip)
    end
  end
  
  def hash_tags
    tags&.map{ |tag| "##{tag.name}" }.join(", ")
  end
end
