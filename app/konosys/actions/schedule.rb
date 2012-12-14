module Konosys
  module Actions
    class Schedule < Konosys::Action

      SCHEDULE_URL = 'https://e-campus.hei.fr/KonosysProd/interfaces/MonPlanning_Utilisateur_Lot.aspx'

      def fetch_current_and_next_week
        login

        @browser.goto(SCHEDULE_URL)
        current_week_source = @browser.xml.force_encoding('utf-8')
        @browser.button(:id, 'semsuiv').click # Move to next week
        next_week_source = @browser.xml.force_encoding('utf-8')

        weeks = Array.new
        weeks.push Models::Week.new(current_week_source)
        weeks.push Models::Week.new(next_week_source)

        weeks
      end
    end
  end
end