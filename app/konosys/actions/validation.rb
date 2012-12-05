module Konosys
  module Actions
    class Validation < Konosys::Action
      def perform
        if login
          {valid: true}
        end
      end
    end
  end
end