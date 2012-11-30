module Konosys
  module Models
    class Course
      attr_accessor :day, :hour, :minutes, :date, :length, :code, :name, :room, :type, :teacher

      def initialize(date, details)
        # Todo: Update date!
        @date = date
        @day = details[0]
        @hour = details[1]
        @minutes = details[2]
        @length = details[3]

        details = details[4].split('<br>')
        if details.count >= 4
          sub_details = details[0].split('-')
          @code = sub_details[0][0..-2]
          @name = sub_details[1][1..-1]
          @room = details[1][6..-1]
          @group = details[2][7..-2]
          @type = details[3]
          @teacher = details[4] if details.count == 5
        else
          @name = details[4]
        end
      end

      class Entity < Grape::Entity
        expose :date, :length, :type, :code, :name, :room, :teacher
      end
    end
  end
end