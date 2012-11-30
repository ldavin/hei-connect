module Konosys
  module Models
    class Week
      attr_accessor :number, :courses

      def initialize(date, courses)
        @number = date.cweek
        @courses = courses
      end

      class Entity < Grape::Entity
        expose :number
        expose :courses, using: Course::Entity
      end
    end
  end
end