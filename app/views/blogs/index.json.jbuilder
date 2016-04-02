json.array!(@blogs) do |blog|
  json.extract! blog, :id, :url, :content, :name, :camp_id
  json.url blog_url(blog, format: :json)
end
