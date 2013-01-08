class SchedulesController < ApplicationController
  version 1

  def show
    client = Konosys::Actions::Schedule.new(params[:username], params[:password])

    begin
      schedule_weeks = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    client.finish

    collection schedule_weeks
  end
end
