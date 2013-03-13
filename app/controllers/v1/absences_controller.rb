module V1
  class AbsencesController < ::ApplicationController
    version 1

    def show
      client = Konosys::Actions::Absences.new(params.slice('username', 'password', 'user_id', 'session_id'))

      begin
        absences = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection absences
    end
  end
end