class Categories < Grape::API
  format :json

  before do
    error!("401 Unauthorized, 401") unless authenticated
  end

  resource :categories do

    desc "Return list of hussars"
    get do
      Category.all.as_json(only: [:id, :title, :description], methods: :books_count)
    end
  end
end