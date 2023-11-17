class TodosClient < ApplicationClient
  BASE_URL = 'http://localhost:3000'

  def todos(**kwargs)
    get '/todos', query: kwargs
  end

  def create_todo(**kwargs)
    post '/todos', body: { todo: kwargs }
  end

  def todo(id)
    get "/todos/#{id}"
  end

  def update_todo(id, **kwargs)
    patch "/todos/#{id}", body: { todo: kwargs }
  end

  def delete_todo(id)
    delete "/todos/#{id}"
  end
end
