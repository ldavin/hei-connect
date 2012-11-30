module Konosys
  class Action
    def initialize(username, password)
      @username = username
      @password = password

      @browser = Celerity::Browser.new
      @browser.javascript_enabled = false
      @browser.css = false
    end

    def finish
      @browser.close
      @browser.clear_cache
      @browser.clear_cookies
    end

    private

    def login
      Konosys::Login.new(@browser, @username, @password).proceed
    end
  end
end