module Solidify
  module Parser
    class Method
      def initialize(code, name)
        @code = code
        @name = name
        @method_lines = []
        @inside_string = false
        @string_opener = false
      end

      def code
        inside_method = false
        @code.each do |line|
          inside_string?(line)
          inside_method = false if inside_method && end?(line)
          @method_lines << line.strip if inside_method
          inside_method = true if def?(line)
        end
        @method_lines
      end

      def def?(line)
        /def #{@name.to_s}/i.match line
      end

      def end?(line)
        return false if inside_string?
        /^[\s]{1,}end$/i.match(line)
      end

      # When iterating through lines, sometimes a string will be started
      # and we need to track that, so that we check if an 'end' is a string
      # or not
      def inside_string?(line = nil)
        return @inside_string if line.nil?

        if @inside_string
          closing_string = line.scan /#{@string_opener}$/
          if !closing_string.empty?
            @inside_string = false
          end
        end

        if !@inside_string
          open_string = line.scan /<<[-]{0,1}(\w{1,})/
          if !open_string.empty?
            @inside_string = true 
            @string_opener = open_string.flatten.first
          end
        end

        @inside_string
      end
    end
  end
end
