module Konosys
  module Models
    class AbsenceSession < Konosys::Model
      attr_reader :id, :name, :student_id

      def initialize(id, name, student_id)
        @id = id.to_i
        @name = name.strip
        @student_id = student_id.to_i
      end

      def as_json
        {
            id: @id,
            name: @name,
            student_id: @student_id
        }
      end
    end
  end
end