class CreateTranslations < ActiveRecord::Migration[6.1]
  def change
    create_table :translations, id: :uuid do |t|
      t.belongs_to :post,       null: false, foreign_key: true,                 type: :uuid
      t.belongs_to :translated, null: false, foreign_key: { to_table: :posts }, type: :uuid
    end
  end
end
