module Konosys
  module Actions
    class Grades < Konosys::Action

      GRADES_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_sessionprogramme_etudiant_Examen.aspx?id_inscriptionsessionprogramme='

      def fetch_session(id)
        login

        @browser.goto(GRADES_URL + id)
        grades = Array.new
        @browser.div(:id, 'liste_instancemodule').rows.each do |row|
          if row.cells.size == 5
            params = row.cells.collect { |cell| cell.text }
            grades.push Models::Grade.new(params)
          end
        end
        grades.shift # We remove the first grade, containing the table headers

        grades
      end
    end
  end
end