module V2
  class UsersController < ApplicationController
    version 2

    def create
      @user = User.new params[:user]

      client = Konosys::Actions::UserAction.new(params[:user].slice('username', 'password'))

      begin
        user = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      @user.username = user.id
      @user.ecampus_user_id = user.user_id
      @user.ecampus_student_id = user.student_id

      @user.save!

      result = @user.attributes.slice 'username', 'token'
      resource result.merge email: user.email
    end

    def show
      @user = User.where(username: params[:user][:username].downcase).first!

      if params[:user][:password] == @user.password
        resource @user.attributes.slice 'username', 'token'
      else
        error! :unauthenticated
      end
    end

    def show_detailed
      client = Konosys::Actions::UserAction.new(user: current_user)

      begin
        user = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      @user = current_user
      @user.username = user.id
      @user.ecampus_user_id = user.user_id
      @user.ecampus_student_id = user.student_id

      @user.save!

      result = @user.attributes.slice 'username', 'token'
      resource result.merge email: user.email
    end
  end
end
