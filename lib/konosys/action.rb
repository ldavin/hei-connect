module Konosys
  class Action
    def initialize(params = {})
      if params.has_key? :user
        user = params[:user]
        @username = user.username
        @password = user.password
        @user_id = user.ecampus_user_id.to_s
        @student_id = user.ecampus_student_id.to_s
      else
        @username = params[:username] if params.has_key? :username
        @password = params[:password] if params.has_key? :password
        @user_id = params[:user_id] if params.has_key? :user_id
        @student_id = params[:student_id] if params.has_key? :student_id
      end

      @session_id = params[:session_id] if params.has_key? :session_id

      @browser = Mechanize.new
    end

    private

    def login
      Konosys::Login.new(@browser, @username, @password).proceed
    end
  end
end