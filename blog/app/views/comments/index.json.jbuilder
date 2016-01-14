json.array!(@comments) do |comment|
  json.extract! comment, :id, :commentText, :author, :blogpost_id
  json.url comment_url(comment, format: :json)
end
