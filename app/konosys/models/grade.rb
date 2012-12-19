module Konosys
  module Models
    class Grade < Konosys::Model
      attr_reader :course, :mark, :program, :semester, :type

      def initialize(data)
        @program = data[0]
        @course = data[1]
        @semester = data[2]
        @type = data[3]
        @mark = data[4].to_f
      end

      def as_json
        {
            program: @program,
            course: @course,
            semester: @semester,
            type: @type,
            mark: @mark
        }
      end
    end
  end
end