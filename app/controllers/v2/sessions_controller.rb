module V2
  class SessionsController < ::ApplicationController
    version 2

    def grades
      client = Konosys::Actions::GradesSessions.new(user: current_user)

      begin
        sessions = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection sessions
    end

    def absences
      client = Konosys::Actions::AbsencesSessions.new(user: current_user)

      begin
        sessions = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection sessions
    end
  end
end