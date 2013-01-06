class SessionsController < ApplicationController
  version 1

  def grades
    client = Konosys::Actions::GradesSessions.new(params[:username], params[:password], params[:student_id])

    begin
      sessions = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    client.finish

    expose sessions
  end
end
