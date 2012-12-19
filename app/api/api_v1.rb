module API
  class API_v1 < Grape::API

    version 'v1', :using => :path

    helpers do
      def logger
        API.logger
      end
    end

    before do
      logger.info {
        log = "#{params[:route_info].route_method} #{params[:route_info].route_version}/" +
            "#{params[:route_info].route_path.split('/')[2..-1].join('/').gsub(/\(.*\)/, '')}"
        log += " for #{params[:username]}" if params[:username]
        log
      }
    end

    desc 'Test the given credentials and return if they are valid'
    get :validate_credentials do
      action = Konosys::Actions::Validation.new(params[:username], params[:password])

      result = begin
        action.perform
        true
      rescue Konosys::Exceptions::LoginError
        logger.error "Login failed for #{params[:username]}"
        false
      ensure
        action.finish
      end

      {valid: result}
    end

    desc 'Fetch the courses of the current and next week'
    get :schedule do
      action = Konosys::Actions::Schedule.new(params[:username], params[:password])

      begin
        weeks = action.fetch_current_and_next_week
      rescue Konosys::Exceptions::LoginError
        logger.error "Login failed for #{params[:username]}"
        error!({error: 'Login failed'}, 401)
      ensure
        action.finish
      end

      {weeks: weeks}
    end

    resource :grades do
      desc 'Fetch the user\'s grades sessions id and name'
      get :sessions do
        action = Konosys::Actions::GradesSessions.new(params[:username], params[:password])

        begin
          sessions = action.fetch_all_sessions
        rescue Konosys::Exceptions::LoginError
          logger.error "Login failed for #{params[:username]}"
          error!({error: 'Login failed'}, 401)
        ensure
          action.finish
        end

        {sessions: sessions}
      end
    end

    resource :system do
      desc 'Simple get request that returns OK'
      get :status do
        {status: 'ok'}
      end
    end
  end
end