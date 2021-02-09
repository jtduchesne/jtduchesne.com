class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :language
      t.string :title
      t.string :preview
      t.date :published_on

      t.timestamps
    end
  end
end
