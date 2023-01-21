module SLA
  module Formatters
    class Simple < Base
      attr_reader :last_source

      def handle(action, page)
        @last_source = page.url if action == :source

        return unless action == :check

        @count += 1

        return if page.valid?

        @failed += 1

        show_status page
      end

    private

      def show_status(page)
        if last_source
          say "m`SOURCE  #{last_source}`"
          @last_source = nil
        end

        say "  r`FAIL`  #{page.depth}  #{page.url}"
        say "   r`#{page.code}`  #{page.error}" unless page.code == 404
      end
    end
  end
end
