module V2
  class GradesController < ::V1::GradesController
    version 2

    def show
      client = Konosys::Actions::Grades.new(user: current_user, session_id: params[:session_id])

      begin
        grades = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection grades
    end

    def show_detailed
      client = Konosys::Actions::GradesDetailed.new(user: current_user, session_id: params[:session_id])

      begin
        grades = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection grades
    end

  end
end