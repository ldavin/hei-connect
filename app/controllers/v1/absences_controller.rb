module V1
  class AbsencesController < ::ApplicationController
    version 1..2

    def show
      client = Konosys::Actions::Absences.new(params[:username], params[:password], params[:user_id], params[:session_id])

      begin
        absences = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection absences
    end
  end
end