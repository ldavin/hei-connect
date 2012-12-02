module API
  class API_v1 < Grape::API

    version 'v1', :using => :path

    resource :test do
      desc 'Test fetching the courses of the current week'
      post :schedule do
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