class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.timestamps
      t.string :email
    end
    add_index :users, :email, unique: true
  end
end
