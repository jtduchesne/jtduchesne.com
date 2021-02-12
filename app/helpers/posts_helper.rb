module PostsHelper
  def options_for_language(selected)
    options_for_select(languages, selected.language_before_type_cast)
  end
  
  def options_for_translated(selected)
    grouped_options_for_select(
      languages.transform_values do |v|
        Post.untranslated.where(language: v).pluck(:title, :slug)
      end,
      selected.translated&.slug,
      prompt: selected.translated&.title || t('none')
    )
  end
  
private
  def languages
    Post.languages.transform_keys{|k| t(Post.languages[k].downcase)}
  end
end
