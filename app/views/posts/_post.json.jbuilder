json.extract! post, :id, :language, :title, :preview, :published_on, :created_at, :updated_at
json.url post_url(post, format: :json)
