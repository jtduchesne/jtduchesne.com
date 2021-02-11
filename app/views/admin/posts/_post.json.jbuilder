json.extract! post, :id, :language, :title
if post.draft?
  json.draft true
  json.created_on post.created_at.to_date
else
  json.draft false
  json.published_on post.published_on
end
json.content post.content.body
json.url url_for(action: 'show', format: :json, only_path: false)
