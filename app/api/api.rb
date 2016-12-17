module API
  class Base < Grape::API

    mount API::Categories
    mount API::Books
  end
end