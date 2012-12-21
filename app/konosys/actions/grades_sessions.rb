module Konosys
  module Actions
    class GradesSessions < Konosys::Action

      GRADES_SESSIONS_STEP1_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'
      GRADES_SESSIONS_STEP2_URL = 'http://e-campus.hei.fr/KonosysProd/pageCentrale.aspx?forceRefresh=true&target=interface_MesCours_notes_etudiant_InscriptionSessionProgramme_lister_SessionProgrammeEtudiant&_id_etudiant_long='

      def fetch_all_sessions
        login

        # Step1: fetch a particular id
        @browser.goto(GRADES_SESSIONS_STEP1_URL)
        student_id = @browser.button(:id, '_id_etudiant_hidden').value

        # Step2: get sessions list thanks to this id
        @browser.goto(GRADES_SESSIONS_STEP2_URL + student_id)
        sessions = Array.new
        data = @browser.xml.scan(/creerLignes .+ title='([^']*)'.+id=(\d+).+id='col2/i)
        data.each do |line|
          sessions.push(Models::GradeSession.new(line))
        end

        sessions
      end
    end
  end
end