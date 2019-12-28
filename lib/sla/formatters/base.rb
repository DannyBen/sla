module SLA
  module Formatters
    class Base
      include Colsole

      attr_accessor :count, :failed

      def initialize
        @count = 0
        @failed = 0
      end

      def success?
        failed == 0
      end

      def handle(action, page)
        raise NotImplementedError
      end

      def footer
        color = success? ? '!txtgrn!' : '!txtred!'
        say "\n\n#{color}Checked #{count} pages with #{failed} failures"
      end

    end
  end
end
