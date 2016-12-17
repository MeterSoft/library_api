class Categories < Grape::API
  format :json

  resource :categories do

    desc "Return list of hussars"
    get do
      Category.all
    end
  end
end