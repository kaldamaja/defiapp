
json.posts do 
	json.array!(@posts) do |post|
		json.title post.title
		json.url post_path(post)

	end
end