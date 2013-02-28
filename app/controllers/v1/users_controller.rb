module V1
  class UsersController < ::ApplicationController
    version 1..2

    def show
      client = Konosys::Actions::User.new(params[:username], params[:password])

      begin
        user = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      resource user
    end
  end
end