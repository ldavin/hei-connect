class SessionsController < ::ApplicationController
  version 1..2

  def grades
    client = Konosys::Actions::GradesSessions.new(params[:username], params[:password], params[:student_id])

    begin
      sessions = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    collection sessions
  end

  def absences
    client = Konosys::Actions::AbsencesSessions.new(params[:username], params[:password], params[:user_id])

    begin
      sessions = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    collection sessions
  end
end