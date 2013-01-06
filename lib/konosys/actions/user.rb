module Konosys
  module Actions
    class User < Konosys::Action

      class UserEntity < APISmith::Smash
        # Regular student's ID, eg: h09123
        property :id
        # Konosys hidden internal ID, eg: 53123
        property :user_id
        # Konosys hidden internal ID, eg: 23123
        property :student_id
      end

      USER_DETAILS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'

      def fetch
        login

        @browser.goto(USER_DETAILS_URL)
        user_id = @browser.button(:id, '_id_user_hidden').value
        student_id = @browser.button(:id, '_id_etudiant_hidden').value

        UserEntity.new id: @username.downcase,
                       user_id: user_id.to_i,
                       student_id: student_id.to_i
      end
    end
  end
end