module V1
  class GradesController < ::ApplicationController
    version 1

    def show
      client = Konosys::Actions::Grades.new(params.slice('username', 'password', 'session_id'))

      begin
        grades = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection grades
    end

  end
end