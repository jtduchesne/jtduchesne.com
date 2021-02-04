class ConvertProjectDescriptionToJson < ActiveRecord::Migration[6.1]
  def change
    say_with_time "Converting Project.description to JSON" do
      Project.find_each do |project|
        next if project.description.is_a?(Hash)
        
        project.update_columns(description: {fr: project.description, en: project.description})
      end
    end
  end
end
