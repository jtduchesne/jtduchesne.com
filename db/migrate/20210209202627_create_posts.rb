class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.timestamps
      t.string :language, null: false, limit: 2, default: "FR"
      t.string :title
      t.string :preview
      t.date   :published_on
    end
    add_index :posts, :language
  end
end
