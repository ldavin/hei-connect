module API
  class API_v1 < Grape::API

    version 'v1', :using => :path

    resource :schedule do
      desc 'Fetch the courses of the current and next week'
      get '/' do
        schedule = Konosys::Actions::Schedule.new(params[:username], params[:password])

        begin
          weeks = schedule.fetch_current_and_next_week
        rescue Konosys::Exceptions::LoginError
          error! 'Login failed', 401
        end

        schedule.finish

        present weeks, with: Konosys::Models::Week::Entity
      end
    end

  end
end