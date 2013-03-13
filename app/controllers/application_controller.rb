class ApplicationController < RocketPants::Base

  def current_user
    User.find_by_token(params[:token]) || User.new
  end

end
