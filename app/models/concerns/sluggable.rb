module Sluggable
  extend ActiveSupport::Concern
  
  included do
    validates :slug, presence: true, uniqueness: true, format: /\A[^\s\\\/@"']+\z/
  end
  
  def to_param
    slug
  end
  
  class_methods do
    def find(*args)
      where({slug: args.unshift}, *args).take || super(*args)
    end
  end
end
