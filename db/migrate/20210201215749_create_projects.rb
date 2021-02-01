class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :live_url
      t.string :github_url

      t.timestamps
    end
  end
end
