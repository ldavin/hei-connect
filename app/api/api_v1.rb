module API
  class API_v1 < Grape::API

    version 'v1', :using => :path

    resource :test do
      post :login do
        client = Konosys::Login.new(params[:username], params[:password])
        client.proceed
      end
    end

  end
end