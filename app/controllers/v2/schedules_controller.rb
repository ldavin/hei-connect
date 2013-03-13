module V2
  class SchedulesController < ::ApplicationController
    version 2

    def show
      client = Konosys::Actions::Schedule.new(user: current_user)

      begin
        schedule_weeks = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection schedule_weeks
    end
  end
end