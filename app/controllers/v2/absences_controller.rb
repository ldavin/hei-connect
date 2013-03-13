module V2
  class AbsencesController < ::ApplicationController
    version 2

    def show
      client = Konosys::Actions::Absences.new(user: current_user, session_id: params[:session_id])

      begin
        absences = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection absences
    end
  end
end