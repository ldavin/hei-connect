module V1
  class SessionsController < ::ApplicationController
    version 1

    def grades
      client = Konosys::Actions::GradesSessions.new(params.slice('username', 'password', 'student_id'))

      begin
        sessions = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection sessions
    end

    def absences
      client = Konosys::Actions::AbsencesSessions.new(params.slice('username', 'password', 'user_id'))

      begin
        sessions = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection sessions
    end
  end
end