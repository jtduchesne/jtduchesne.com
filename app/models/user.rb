class User < ApplicationRecord
  # Attributes: email, token, verified_at, (otp), otp_digest
  
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+@[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+\z/ }
  
  has_one :role, -> { readonly }
  
  include OnetimePassword
  has_onetime_password
  
  before_validation :readonly!, if: :admin?, on: :update
  before_destroy    :readonly!, if: :admin?
  
  def admin?
    role.present? && role.administrator?
  end
  
  has_secure_token
  attr_readonly :token
  
  scope :verified,   -> { where.not(verified_at: nil) }
  scope :unverified, -> { where(verified_at: nil) }
  
  def verified?
    verified_at.present?
  end
  
  def verify!(token)
    if token == self.token
      unless verified?
        touch :verified_at
        generate_onetime_password
      end
      self
    end
  end
  def self.verify!(token)
    find_by(token: token).try(:verify!, token)
  end
  
private
  def make_admin!
    create_role! do |role|
      role.administrator!
    end
  end
end
