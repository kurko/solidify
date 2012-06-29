module Solidify
  module Analysis
    class MethodResponsibility
      def initialize(code)
        @code = code
      end

      def too_many_lines?
        @code.length > 5
      end
    end
  end
end
