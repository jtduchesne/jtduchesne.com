class AddSlugColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :slug, :string
    
    Post.find_each do |post|
      post.update! slug: post.title.parameterize
    end
    change_column_null :posts, :slug, false
    
    add_index :posts, :slug, unique: true
  end
end
