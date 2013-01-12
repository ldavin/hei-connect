class GradesController < ApplicationController
  version 1

  def show
    client = Konosys::Actions::Grades.new(params[:username], params[:password], params[:session_id])

    begin
      grades = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    client.finish

    collection grades
  end
end
