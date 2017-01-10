module API
  class Base < Grape::API

    # rescue_from :all, backtrace: true
    # error_formatter :json, ErrorFormatter

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        binding.pry
        return true if warden.authenticated?
        params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
      end

      def current_user
        warden.user || @user
      end
    end

    mount API::Categories
    mount API::Books
    mount API::Sessions
  end
end