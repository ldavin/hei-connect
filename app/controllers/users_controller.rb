class UsersController < ApplicationController
  version 1

  def show
    client = Konosys::Actions::User.new(params[:username], params[:password])

    begin
      user = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    client.finish

    resource user
  end
end
