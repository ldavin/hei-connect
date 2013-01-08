module Konosys
  module Actions
    class User < Konosys::Action

      class UserEntity < APISmith::Smash
        # Regular student's ID, eg: h09123
        property :id, :transformer => lambda { |t| t.downcase }
        # Konosys hidden internal ID, eg: 53123
        property :user_id, :transformer => :to_i
        # Konosys hidden internal ID, eg: 23123
        property :student_id, :transformer => :to_i
      end

      USER_DETAILS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'

      def fetch
        login

        @browser.goto(USER_DETAILS_URL)
        user_id = @browser.button(:id, '_id_user_hidden').value
        student_id = @browser.button(:id, '_id_etudiant_hidden').value

        UserEntity.new id: @username,
                       user_id: user_id,
                       student_id: student_id
      end
    end
  end
end