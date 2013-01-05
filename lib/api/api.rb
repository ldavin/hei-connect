module API
  class API < Grape::API
    format :json
    mount ::API::API_v1
  end
end