class AddTokenColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token, :string, limit: 24, null: true
    add_column :users, :verified_at, :datetime, null: true
    
    up_only do
      say_with_time "Generating tokens for existing users" do
        count = 0
        User.find_each do |user|
          if user.admin?
            Role.find(user.role.id).destroy!
            user = user.reload
            user.regenerate_token
            user.verify!(user.token)
            user.send :make_admin!
          else
            user.regenerate_token
          end
          count += 1
        end
        count
      end
      change_column_null :users, :token, false
    end
    
    add_index :users, :token, unique: true
  end
end
