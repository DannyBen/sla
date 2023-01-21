module SLA
  module Formatters
    class Verbose < Base
      def handle(action, page)
        case action
        when :source
          say "\nm`SOURCE  #{page.url}`"

        when :check
          show_check_status page

        when :skip
          say "  b`SKIP`  #{page.depth}  #{page.url}"

        end
      end

    private

      def show_check_status(page)
        @count += 1

        show_error = false

        if page.valid?
          status = 'PASS'
          color = 'g'
        else
          @failed += 1
          status = 'FAIL'
          color = 'r'
          show_error = page.code != 404
        end

        say "  #{color}`#{status}`  #{page.depth}  #{page.url}"
        say "   r`#{page.code}`  #{page.error}" if show_error
      end
    end
  end
end
