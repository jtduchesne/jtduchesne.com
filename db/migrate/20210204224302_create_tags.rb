class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags, id: :uuid do |t|
      t.timestamps
      t.string :name
    end
    add_index :tags, :name, unique: true
  end
end
