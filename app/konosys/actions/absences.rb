module Konosys
  module Actions
    class Absences < Konosys::Action

      ABSENCES_URL_PART_1 = 'http://e-campus.hei.fr/KonosysProd/pageCentrale.aspx?forceRefresh=true&target=interface_lister_MesAbsence_etudiant_Absence_Rechercher_AbsenceEtudiant&_id_user_connecte_long='
      ABSENCES_URL_PART_2 = '&_Excuse_string=1&_ddl_sessionprogramme_string='
      ABSENCES_URL_PART_3 = '&_DateDebut_string=&_DateFin_string='

      def fetch_session(user_id, session_id)
        login

        @browser.goto(ABSENCES_URL_PART_1 + user_id + ABSENCES_URL_PART_2 + session_id + ABSENCES_URL_PART_3)

        absences = Array.new
        data = @browser.xml.scan(/title='(\d+)\/(\d+)\/(\d+)' .+? id='col5 .+? title='(\d+):(\d+)-(\d+):(\d+)' .+? id='col7 .+? title='(.+?)' .+? id='col8 .+? title='(.+?)' .+? id='col9 .+? title='(.+?)'/x)
        data.each do |line|
          absences.push(Models::Absence.new)
        end
      end

      grades
    end
  end
end
end