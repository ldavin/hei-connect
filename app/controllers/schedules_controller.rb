class SchedulesController < ::ApplicationController
  version 1..2

  def show
    client = Konosys::Actions::Schedule.new(params[:username], params[:password])

    begin
      schedule_weeks = client.fetch
    rescue Konosys::Exceptions::LoginError
      error! :unauthenticated
    end

    collection schedule_weeks
  end
end