module Konosys
  module Actions
    class Schedule < Konosys::Action

      SCHEDULE_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/MonPlanning_Utilisateur_Lot.aspx'

      def get_current_week
        login

        # Fetch schedule page source
        @browser.goto(SCHEDULE_URL)
        source = @browser.xml

        # Fetch date from hidden form input
        date_components = source.scan(/name="_DateDebutSemaine_hidden" type="text" value="(\d+)\/(\d+)\/(\d+)"/)
        # date_components is like [['20', '11', '1990']]
        date = Date.new(*date_components.flatten.reverse.collect { |i| i.to_i })

        # Fetch courses
        courses = Array.new
        data = source.scan(/AjouterRDV\((\d+),(\d+),(\d+),(\d+),'(.+?)',/i) # Data comes from a JS source
        data.each do |d|
          courses.push(Models::Course.new(date, d))
        end

        # Create and return a week object
        Models::Week.new(date, courses)
      end
    end
  end
end