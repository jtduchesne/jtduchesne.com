class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings, id: :uuid do |t|
      t.belongs_to :tag,      type: :uuid, foreign_key: true
      t.belongs_to :taggable, type: :uuid, polymorphic: true
      t.index [:tag_id, :taggable_id]
    end
  end
end
