module Konosys
  class Login
    def initialize(username, password)
      @username = username
      @password = password

      @login_url = 'http://e-campus.hei.fr/KonosysProd/PC_MV_login.aspx'

      @browser = Celerity::Browser.new
      @browser.javascript_enabled = false
    end

    def proceed
      @browser.goto(@login_url)
      @browser.text_field(:id, 'Username').value = @username
      @browser.text_field(:id, 'Password').value = @password
      @browser.button(:name, 'Button1').click

      if @browser.url == @login_url
        @browser.close
        false
      else
        true
      end
    end
  end
end