class CreateAbouts < ActiveRecord::Migration[6.1]
  def change
    create_table :abouts, id: :uuid do |t|
      t.timestamps
    end
  end
end
