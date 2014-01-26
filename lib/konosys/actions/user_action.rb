module Konosys
  module Actions
    class UserAction < Konosys::Action

      class UserEntity < APISmith::Smash
        # Regular student's ID, eg: h09123
        property :id, :transformer => lambda { |t| t.downcase }
        # Konosys hidden internal ID, eg: 53123
        property :user_id, :transformer => :to_i
        # Konosys hidden internal ID, eg: 23123
        property :student_id, :transformer => :to_i
        # Student's email guessed from his name
        property :email
      end

      USER_DETAILS_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/interface_MesCours_notes_etudiant.aspx'
      USER_WELCOME_URL = 'http://e-campus.hei.fr/KonosysProd/interfaces/Bureau_Demo.aspx'

      def fetch
        login

        page = @browser.get USER_DETAILS_URL
        user_id = page.forms.first.field('_id_user_hidden').value
        student_id = page.forms.first.field('_id_etudiant_hidden').value

        page = @browser.get USER_WELCOME_URL
        name = page.body.force_encoding('utf-8').scan(/<strong>Bonjour (.*),<br\/>/i)
        name = I18n.transliterate(name.flatten.first)

        first_names = name.scan(/([A-Z]{1}[a-z][^\s]*)/)
        first_name = stringify first_names

        last_names = name.scan(/([A-Z][^a-z][^\s]*)/)
        last_name = stringify last_names

        email = "#{first_name}.#{last_name}@hei.fr"

        UserEntity.new id: @username,
                       user_id: user_id,
                       student_id: student_id,
                       email: email
      end

      def stringify regex_result
        content = regex_result.flatten.join '-'
        content = content.downcase.strip
        content = content.tr "'", ""
        content = content.tr " ", ""

        content
      end
    end
  end
end