json.extract! about, :id, :created_at, :updated_at

json.image rails_blob_url(about.image, disposition: "attachment", locale: nil)
json.fr about.fr.body
json.en about.en.body

json.draft about.draft?
json.published do
  json.extract! about, :from, :to
end

json.url url_for(action: 'show', format: :json, only_path: false)
