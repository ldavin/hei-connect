module Konosys
  class Action
    def initialize(username, password)
      @username = username
      @password = password

      @browser = Mechanize.new
    end

    private

    def login
      Konosys::Login.new(@browser, @username, @password).proceed
    end
  end
end