module Konosys
  module Actions
    class AbsencesSessions < Konosys::Action

      class AbsenceSessionEntity < APISmith::Smash
        # Session ID, eg: 51
        property :id, :transformer => :to_i
        # Session name, eg: Cycle ing\u00e9nieur 2013-3A
        property :name, :transformer => lambda { |t| t.strip }
      end

      ABSENCES_SESSIONS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_lister_MesAbsence_etudiant.aspx'

      def fetch
        login

        page = @browser.get ABSENCES_SESSIONS_URL

        options = page.forms.first.field('ddl_sessionprogramme').options
        options.shift

        sessions = Array.new
        options.each do |option|
          sessions.push(AbsenceSessionEntity.new id: option.value, name: option.text)
        end

        sessions
      end
    end
  end
end