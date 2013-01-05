module Konosys
  module Actions
    class Validation < Konosys::Action
      def perform
        login
      end
    end
  end
end