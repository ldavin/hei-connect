module Konosys
  module Models
    class Base
      def to_json(*a)
        as_json.to_json(*a)
      end
    end
  end
end