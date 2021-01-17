class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+@[^@,()<>{}\[\]"'\\\/\s[:^ascii:]]+\z/ }
end
