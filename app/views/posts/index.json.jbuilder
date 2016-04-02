json.array!(@posts) do |post|
  json.extract! post, :id, :url, :content, :active, :title, :date, :ordre, :blog_id
  json.url post_url(post, format: :json)
end
