module Konosys
  module Actions
    class Absences < Konosys::Action

      class AbsenceEntity < APISmith::Smash
        # Absence's datetime with timezone, eg: 2013-01-07T08:00:00+01:00
        property :date
        # Absence's length, eg: 90
        property :length, :transformer => :to_i
        # Absence's course, eg: Traitement du signal
        property :course, :transformer => lambda { |t| CGI.unescapeHTML t.strip }
        # Absence's excused boolean, eg: true
        property :excused
        # Absence's justification, eg: .
        property :justification, :transformer => lambda { |t| CGI.unescapeHTML t.strip }
      end

      ABSENCES_URL_PART_1 = 'http://e-campus.hei.fr/KonosysProd/pageCentrale.aspx?forceRefresh=true&target=interface_lister_MesAbsence_etudiant_Absence_Rechercher_AbsenceEtudiant&_id_user_connecte_long='
      ABSENCES_URL_PART_2 = '&_Excuse_string=1&_ddl_sessionprogramme_string='
      ABSENCES_URL_PART_3 = '&_DateDebut_string=&_DateFin_string='

      def initialize(username, password, user_id, session_id)
        super username, password
        @user_id = user_id
        @session_id = session_id
      end

      def fetch
        login

        page = @browser.get ABSENCES_URL_PART_1 + @user_id + ABSENCES_URL_PART_2 + @session_id + ABSENCES_URL_PART_3

        absences = Array.new
        data = page.body.force_encoding('utf-8').scan(/title='(\d+)\/(\d+)\/(\d+)' .+? id='col5 .+? title='(\d+):(\d+)-(\d+):(\d+)' .+? id='col7 .+? title='(.+?)' .+? id='col8 .+? title='(.+?)' .+? id='col9 .+? title='(.+?)'/xm)
        data.each do |raw_absence|
          date = Time.local raw_absence[2], raw_absence[1], raw_absence[0], raw_absence[3], raw_absence[4]
          absences.push(AbsenceEntity.new date: date,
                                          length: (date.clone.change(hour: raw_absence[5], min: raw_absence[6]) - date) / 60,
                                          course: raw_absence[7], excused: raw_absence[8] == 'Non' ? false : true,
                                          justification: raw_absence[9])
        end

        absences
      end
    end
  end
end