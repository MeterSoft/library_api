class Books < Grape::API
    format :json

    before do
      header 'Access-Control-Allow-Origin', '*'
      header 'Access-Control-Allow-Methods', '*'
    end
end