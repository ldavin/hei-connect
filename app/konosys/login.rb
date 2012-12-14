module Konosys
  class Login

    LOGIN_URL = 'https://e-campus.hei.fr/KonosysProd/PC_MV_login.aspx'

    def initialize(browser, username, password)
      @browser = browser
      @username = username
      @password = password
    end

    def proceed
      @browser.goto(LOGIN_URL)
      @browser.text_field(:id, 'Username').value = @username
      @browser.text_field(:id, 'Password').value = @password
      @browser.button(:name, 'Button1').click

      if @browser.url == LOGIN_URL
        raise Exceptions::LoginError
      else
        true
      end
    end
  end
end