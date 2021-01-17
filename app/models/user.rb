class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+@[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+\z/ }
  
  has_one :role, -> { readonly }
  
  before_validation :readonly!, if: :admin?, on: :update
  before_destroy    :readonly!, if: :admin?
  
  def admin?
    role.present? && role.administrator?
  end
  
private
  def make_admin!
    create_role! do |role|
      role.administrator!
    end
  end
end
