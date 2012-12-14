module Konosys
  module Models
    class Course < Konosys::Model
      attr_reader :date, :length, :code, :name, :room, :group, :type, :teacher

      def initialize(date, details)
        # Todo: Update date!
        day = details[0]
        hour = details[1]
        minutes = details[2]
        course_date = date + (day.to_i - 1)
        @date = ActiveSupport::TimeZone['Paris'].parse("#{course_date.year}/#{course_date.month}/#{course_date.day}" +
                                                           " #{hour.to_i}h#{minutes.to_i}")
        @length = details[3].to_i

        details = details[4].gsub(/#{Regexp.escape('\\')}/, '').split('<br>')
        if details.count >= 4
          sub_details = details[0].split('-')
          @code = sub_details[0][0..-2]
          @name = sub_details[1][1..-1]
          @room = details[1][6..-1]
          @group = details[2][7..-2]
          @type = details[3]
          @teacher = details[4] if details.count == 5
        else
          @name = details.join ' '
        end
      end

      def as_json
        {
            date: @date,
            length: @length,
            type: @type,
            group: @group,
            code: @code,
            name: @name,
            room: @room,
            teacher: @teacher
        }
      end
    end
  end
end