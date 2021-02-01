class Message < ApplicationRecord
  # Attributes: from, subject, body
  
  validates_presence_of :from, :subject, :body
  
  enum subject: %w(message suggestion bug).map{ |v| [v, v] }.to_h
  
  default_scope -> { order(:created_at) }
  scope :read,   -> { where("created_at <> updated_at") }
  scope :unread, -> { where("created_at = updated_at") }
  
  def read?
    created_at != updated_at
  end
  def unread?
    created_at == updated_at
  end
  
  def read!
    touch(:updated_at) unless read?
  end
end
