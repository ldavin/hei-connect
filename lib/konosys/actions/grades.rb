module Konosys
  module Actions
    class Grades < Konosys::Action

      class GradeEntity < APISmith::Smash
        # Grade's program, eg: HEI0_TC_Annualisé_OPTECH
        property :program, :transformer => lambda { |t| t.strip }
        # Grade's course, eg: Banque, finance, assurance
        property :course, :transformer => lambda { |t| t.strip }
        # Grade's semester, eg: Automne/Fall
        property :semester, :transformer => lambda { |t| t.strip }
        # Grade's type, eg: Partiel / Devoir Surveillé
        property :type, :transformer => lambda { |t| t.strip }
        # Grade's mark, eg: 15.0
        property :mark, :transformer => :to_f
      end

      GRADES_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_sessionprogramme_etudiant_Examen.aspx?id_inscriptionsessionprogramme='

      def fetch
        login

        page = @browser.get GRADES_URL + @session_id
        rows = page.search('div#liste_instancemodule tr')

        grades = Array.new
        rows.each do |row|
          tds = row.children.search('td')
          if tds.count == 5
            raw_grade = tds.collect { |td| td.children.children.to_s }
            grades.push GradeEntity.new program: raw_grade[0], course: raw_grade[1], semester: raw_grade[2],
                                        type: raw_grade[3], mark: raw_grade[4]
          end
        end
        grades.shift # We remove the first grade, containing the table headers

        grades
      end
    end
  end
end