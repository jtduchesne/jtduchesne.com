module PostsHelper
  def options_for_language
    Post.languages.transform_keys{|k| t(Post.languages[k].downcase)}
  end
end
