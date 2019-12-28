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
        # :nocov:
        raise NotImplementedError
        # :nocov:
      end

      def footer_prefix
        "\n"
      end

      def footer
        color = success? ? '!txtgrn!' : '!txtred!'
        say "#{footer_prefix}#{color}Checked #{count} pages with #{failed} failures"
      end

    end
  end
end
