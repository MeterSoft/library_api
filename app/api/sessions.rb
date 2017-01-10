class Sessions < Grape::API
  format :json

  resource :sessions do

   desc "Authenticate user and return user object / access token"

   post do
     username = params[:username]
     password = params[:password]

     return error!({username: "Can not by blank"}, 401) if username.nil?
     return error!({password: "Can not by blank"}, 401) if password.nil?

     user = User.where(username: username.downcase).first
     return error!({username: "Invalid name or password", password: "Invalid name or password"}, 401) if user.nil?

     if !user.valid_password?(password)
       return error!({username: "Invalid name or password", password: "Invalid name or password"}, 401)
     else
       user.ensure_authentication_token!
       user.save
       { success: true, access_token: user.authentication_token, user: { id: user.id } }
     end
   end

   desc "Destroy the access token"
   params do
     requires :access_token, type: String, desc: "User Access Token"
   end
   delete ':access_token' do
     access_token = params[:access_token]
     user = User.where(authentication_token: access_token).first
     if user.nil?
       error!({error: "Invalid access token."},401)
       return
     else
       user.reset_authentication_token
       #{status: 'ok'}
     end
   end
  end
end
