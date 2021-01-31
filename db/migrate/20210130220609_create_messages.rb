class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.timestamps
      t.string :from
      t.string :subject
      t.string :body
    end
  end
end
