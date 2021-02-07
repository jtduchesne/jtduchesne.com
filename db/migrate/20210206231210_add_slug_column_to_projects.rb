class AddSlugColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :slug, :string
    
    Project.find_each do |project|
      project.update! slug: project.name.parameterize
    end
    change_column_null :projects, :slug, false
    
    add_index :projects, :slug, unique: true
  end
end
