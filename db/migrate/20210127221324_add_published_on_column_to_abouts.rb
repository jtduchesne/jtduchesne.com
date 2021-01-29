class AddPublishedOnColumnToAbouts < ActiveRecord::Migration[6.1]
  def change
    add_column :abouts, :published_on, :date, null: true, default: nil
  end
end
