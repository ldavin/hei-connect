module Konosys
  module Actions
    class AbsencesSessions < Konosys::Action

      ABSENCES_SESSIONS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_lister_MesAbsence_etudiant.aspx'

      def fetch_all_sessions
        login

        @browser.goto(ABSENCES_SESSIONS_URL)
        student_id = @browser.button(:id, '_id_user_connecte_hidden').value

        sessions = Array.new
        data = @browser.select_list(:id, 'ddl_sessionprogramme').as_xml.delete("\n").scan(/<option value="(\d+)">(.+?)<\/option>/)
        data.each do |line|
          sessions.push(Models::AbsenceSession.new line[0], line[1], student_id)
        end

        sessions
      end
    end
  end
end