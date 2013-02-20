module Konosys
  class Login

    LOGIN_URL = 'http://e-campus.hei.fr/KonosysProd/PC_MV_login.aspx'

    def initialize(browser, username, password)
      @browser = browser
      @username = username
      @password = password
    end

    def proceed
      page = @browser.get LOGIN_URL

      form = page.form id: 'pc_mv_login'
      form.Username = @username
      form.Password = @password

      page = @browser.submit form, form.buttons.first

      if page.uri.to_s == LOGIN_URL
        raise Exceptions::LoginError
      else
        true
      end
    end
  end
end