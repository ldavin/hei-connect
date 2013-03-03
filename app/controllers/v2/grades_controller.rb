module V2
  class GradesController < ::V1::GradesController
    version 2

    def show_detailed
      client = Konosys::Actions::GradesDetailed.new(params[:username], params[:password], params[:session_id])

      begin
        grades = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection grades
    end

  end
end