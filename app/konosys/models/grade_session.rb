module Konosys
  module Models
    class GradeSession < Konosys::Model
      attr_reader :id, :name

      def initialize(data)
        @name = data[0]
        @id = data[1].to_i
      end

      def as_json
        {
            id: @id,
            name: @name
        }
      end
    end
  end
end