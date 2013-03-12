module V1
  class UsersController < ::ApplicationController
    version 1

    def show
      client = Konosys::Actions::UserAction.new(params[:username], params[:password])

      begin
        user = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      resource user
    end
  end
end