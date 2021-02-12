class Translation < ApplicationRecord
  belongs_to :post
  belongs_to :translated, class_name: "Post"
end
