module V1
  class SchedulesController < ::ApplicationController
    version 1

    def show
      client = Konosys::Actions::Schedule.new(params.slice('username', 'password'))

      begin
        schedule_weeks = client.fetch
      rescue Konosys::Exceptions::LoginError
        error! :unauthenticated
      end

      collection schedule_weeks
    end
  end
end