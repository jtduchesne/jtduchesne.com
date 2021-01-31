class Message < ApplicationRecord
  # Attributes: from, subject, body
  
  validates_presence_of :from, :subject, :body
  
  default_scope -> { order(:created_at) }
end
