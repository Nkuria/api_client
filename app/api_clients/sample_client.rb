class SampleClient < ApplicationClient
    BASE_URL = "https://example.com"

    def posts
        get '/posts'
    end

    def update_post(id, description:)
        patch("/posts/#{id}", body: {post: {description: description}})
    end

    def delete_post(id)
        delete("/posts/#{id}")
    end
end