module Konosys
  module Actions
    class GradesSessions < Konosys::Action

      class GradeSessionEntity < APISmith::Smash
        # Session ID, eg: 12345
        property :id
        # Session name, eg: HEI - 2013-5A -  HEI CAMPUS LILLE (2012 - 2013)
        property :name
      end

      GRADES_SESSIONS_STEP1_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'
      GRADES_SESSIONS_STEP2_URL = 'http://e-campus.hei.fr/KonosysProd/pageCentrale.aspx?forceRefresh=true&target=interface_MesCours_notes_etudiant_InscriptionSessionProgramme_lister_SessionProgrammeEtudiant&_id_etudiant_long='

      def initialize(username, password, student_id = nil)
        super username, password
        @student_id = student_id
      end

      def fetch
        login

        if @student_id.nil?
          # Step1: fetch the student id (konosys internal id)
          @browser.goto(GRADES_SESSIONS_STEP1_URL)
          @student_id = @browser.button(:id, '_id_etudiant_hidden').value
        end

        # Step2: get sessions
        @browser.goto(GRADES_SESSIONS_STEP2_URL + @student_id)
        sessions = Array.new
        data = @browser.xml.scan(/creerLignes .+ title='([^']*)'.+id=(\d+).+id='col2/i)
        data.each do |raw_session|
          sessions.push(GradeSessionEntity.new id: raw_session[1].to_i, name: raw_session[0])
        end

        sessions
      end
    end
  end
end