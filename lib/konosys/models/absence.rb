module Konosys
  module Models
    class Absence < Konosys::Model
      attr_reader :cause, :course, :date, :excused, :hours

      def initialize(data)
        @program = data[0]
        @course = data[1]
        @semester = data[2]
        @type = data[3]
        @mark = data[4].to_f
      end

      def as_json
        {
            date: @date,
            hours: @hours,
            course: @course,
            excused: @excused,
            cause: @cause
        }
      end
    end
  end
end