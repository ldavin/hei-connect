class AbsencesController < ApplicationController
  version 1

  def show
    client = Konosys::Actions::Absences.new(params[:username], params[:password], params[:user_id], params[:session_id])

    begin
      absences = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    client.finish

    collection absences
  end
end