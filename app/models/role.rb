class Role < ApplicationRecord
  # Attributes: name
  
  validates :name, presence: true, uniqueness: true
  
  attr_readonly :name
  
  belongs_to :user, -> { readonly }
  
  def administrator?
    self[:name] == "Administrator"
  end
  def administrator!
    update!(name: "Administrator")
  end
end
