module Solidify
  module Parser
    class File
      def initialize(code)
        @code = code
      end

      def parse_methods_names
        methods = []
        @code.each do |e|
          if e[/def (\w{1,})/i]
            methods << e.scan(/def (\w{1,})/i).flatten.map { |m| m.to_sym }
          end
        end
        methods.flatten
      end

      def method_code(method_name, method_class = Solidify::Parser::Method)
        method_class.new(@code, method_name).code
      end
    end
  end
end
