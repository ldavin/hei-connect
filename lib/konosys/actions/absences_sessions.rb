module Konosys
  module Actions
    class AbsencesSessions < Konosys::Action

      class AbsenceSessionEntity < APISmith::Smash
        # Session ID, eg: 51
        property :id
        # Session name, eg: Cycle ing\u00e9nieur 2013-3A
        property :name
      end

      ABSENCES_SESSIONS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_lister_MesAbsence_etudiant.aspx'

      def initialize(username, password, user_id = nil)
        super username, password
        @user_id = user_id
      end

      def fetch
        login

        @browser.goto(ABSENCES_SESSIONS_URL)

        if @user_id.nil?
          @student_id = @browser.button(:id, '_id_user_connecte_hidden').value
        end

        sessions = Array.new
        data = @browser.select_list(:id, 'ddl_sessionprogramme').as_xml.delete("\n").scan(/<option value="(\d+)">(.+?)<\/option>/)
        data.each do |raw_session|
          sessions.push(AbsenceSessionEntity.new id: raw_session[0].to_i, name: raw_session[1].strip)
        end

        sessions
      end
    end
  end
end