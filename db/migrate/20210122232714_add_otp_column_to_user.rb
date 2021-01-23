class AddOtpColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :otp_digest, :string, null: true
  end
end
