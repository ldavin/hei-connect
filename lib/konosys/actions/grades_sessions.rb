module Konosys
  module Actions
    class GradesSessions < Konosys::Action

      class GradeSessionEntity < APISmith::Smash
        # Session ID, eg: 12345
        property :id, :transformer => :to_i
        # Session name, eg: HEI - 2013-5A -  HEI CAMPUS LILLE (2012 - 2013)
        property :name, :transformer => lambda { |t| t.strip }
      end

      GRADES_SESSIONS_STEP1_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'
      GRADES_SESSIONS_STEP2_URL = 'http://e-campus.hei.fr/KonosysProd/pageCentrale.aspx?forceRefresh=true&target=interface_MesCours_notes_etudiant_InscriptionSessionProgramme_lister_SessionProgrammeEtudiant&_id_etudiant_long='

      def initialize(username, password, student_id = nil)
        super username, password
        @student_id = student_id
      end

      def fetch
        login

        # Step1: fetch the student id (konosys internal id)
        if @student_id.nil?
          page = @browser.get GRADES_SESSIONS_STEP1_URL
          @student_id = page.forms.first.field('_id_etudiant_hidden').value
        end

        # Step2: get sessions
        page = @browser.get GRADES_SESSIONS_STEP2_URL + @student_id
        sessions = Array.new
        data = page.body.force_encoding('utf-8').scan(/creerLignes .+ title='([^']*)'.+id=(\d+).+id='col2/i)
        data.each do |raw_session|
          sessions.push(GradeSessionEntity.new id: raw_session[1], name: raw_session[0])
        end

        sessions
      end
    end
  end
end