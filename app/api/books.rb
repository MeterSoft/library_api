class Books < Grape::API
    format :json

    # before do
    #   header 'Access-Control-Allow-Origin', '*'
    #   header 'Access-Control-Allow-Methods', '*'
    # end

    helpers do
      def find_category
        @category = Category.find(params[:category_id])
        error!('Category fot found', 401) unless @category
      end
    end

    resource :books do

      desc "Return list of books without category"
      get do
        Book.order('created_at desc').as_json(only: [:id, :title, :description], include: { category: { only: [:id, :title] } })
      end
    end

    resource :categories do
      route_param :category_id do
        resource :books do


          desc "Return list of books by category"
          get do
            find_category
            @category.books.order('created_at desc')
          end

          desc "Return full info about book"
          get ':id' do
            find_category
            @book = @category.books.find(params[:id])
            if @book
              @book
            else
              error!('Book not found', 401)
            end
          end

          delete ':id' do
            find_category
            @book = @category.books.find(params[:id])
            if @book
              if @book.destroy
                { success: true }
              else
                error!('Book not found', 401)
              end
            else
              error!('Book not found', 401)
            end
          end

          params do
            optional :title, type: String
            optional :description, type: String
            optional :file, type: File
          end
          post do
            binding.pry
            find_category
            @book = @category.books.build({ title: params[:title], 
                                  description: params[:description], 
                                  file: params[:file] })
            if @book.save
              { success: true }
            else
              error!(@book.errors.full_messages, 401)
            end
          end

          put ':id' do
            find_category
            @book = @category.books.find(params[:id])
            if @book
              if @book.update_attributes({ title: params[:title], 
                                           description: params[:description] })
                { success: true }
              else
                error!('Book not found', 401)
              end
            else
              error!('Book not found', 401)
            end
          end

      end
    end
  end
end