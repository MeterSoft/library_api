class Categories < Grape::API
  format :json

  before do
    header 'Access-Control-Allow-Origin', '*'
    header 'Access-Control-Allow-Methods', '*'
  end

  resource :categories do

    desc "Return list of hussars"
    get do
      Category.all.as_json(only: [:id, :title, :description], methods: :books_count)
    end
  end
end